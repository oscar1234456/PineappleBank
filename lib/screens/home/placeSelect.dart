import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/place.dart';
import 'package:food_bank_auth/util/loadingIndicator.dart';
import 'package:food_bank_auth/util/mapLoadingDialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:food_bank_auth/util/constants.dart';

class placeSelect extends StatefulWidget {
  @override
  State<placeSelect> createState() => placeSelectState();
}

class placeSelectState extends State<placeSelect> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  GoogleMapController googleMapController;

  // Position posi =
  //     Position(longitude: 37.42796133580664, latitude: -122.085749655962);
  Position posi;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    reqPer();
    print("Now in initState");
  }

  void reqPer() async {
    await Geolocator.requestPermission();
  }

  Future<Position> get nowPosition async {
    print("Now in nowPosition");
    Position posi;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      print("posi的狀況：");
      posi = value;
    });
    return posi;
    // print(posi);
    // print("nowPosition: ${posi.latitude}");
    // print("nowPosition: ${posi.longitude}");
  }

  void setCustomMapPin() async {
    // pinLocationIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.5), 'assets/test.png');
    pinLocationIcon =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
    // pinLocationIcon
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9862129, 121.4668882),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final Set<Marker> _markers = {
    // Marker(
    //   markerId: MarkerId("123"),
    //   position: LatLng(37.43296265331129, -122.08832357078792),
    //   infoWindow: InfoWindow(
    //     title: "SSS",
    //     snippet: "新北土城",
    //   ),
    // ),
  };
  final String loadingTest = "Finding Your Location";

  @override
  Widget build(BuildContext context) {
    print("Now in build");
    return Scaffold(
      appBar: AppBar(
          title: Text("Select your Place"),
          backgroundColor: Colors.orangeAccent[200],
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              SearchMapPlaceWidget(
                iconColor: InputCursorColor,
                apiKey: "Your API Key",
                hasClearButton: true,
                placeType: PlaceType.address,
                placeholder: "Enter the location",
                onSelected: (Place place) async {
                  MapLoadingDialogBuilder(context)
                      .showLoadingIndicator(loadingTest);
                  Geolocation geolocation = await place.geolocation;
                  Navigator.of(context).pop();
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLng(geolocation.coordinates));
                  googleMapController.animateCamera(
                      CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: SizedBox(
                  //TODO:Set to mobile height
                  height: 680.0,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) async {
                      _controller.complete(controller);
                      googleMapController = controller;
                      MapLoadingDialogBuilder(context)
                          .showLoadingIndicator(loadingTest);
                      Position posi = await nowPosition;
                      Navigator.of(context).pop();
                      setState(() {
                        print("in onMapCreated setState");
                        print(posi);
                        _markers.add(Marker(
                          onTap: () {
                            showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        "Notice",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      content: Text(
                                        "Are you sure to select this place?",
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                      actions: [
                                        FlatButton(
                                          textColor: Colors.orangeAccent,
                                          onPressed: () async {
                                            List<Placemark> placemark =
                                                await placemarkFromCoordinates(
                                                    posi.latitude,
                                                    posi.longitude);
                                            print(
                                                "GEOLOCATOR: ${placemark[0]}");
                                            SelectPlace selectPlace =
                                                SelectPlace(
                                              allLocation: placemark[0].street,
                                              city: placemark[0]
                                                  .administrativeArea,
                                              district: placemark[0].locality,
                                              no: placemark[0]
                                                  .subAdministrativeArea,
                                              postCode: placemark[0].postalCode,
                                              street: placemark[0].thoroughfare,
                                              latitude: posi.latitude,
                                              longitude: posi.longitude,
                                            );
                                            Navigator.pop(context);
                                            Navigator.pop(context, selectPlace);
                                          },
                                          child: Text(
                                            "Yes",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: wordsSize_S,
                                            ),
                                          ),
                                        ),
                                        FlatButton(
                                          textColor: Colors.grey,
                                          onPressed: () {
                                            print("Naci cancel!");
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: wordsSize_S,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          markerId: MarkerId("789"),
                          position: LatLng(posi.latitude, posi.longitude),
                          infoWindow: InfoWindow(
                            title: "I am a current location!",
                            snippet: "新北市土城區",
                          ),
                          icon: pinLocationIcon,
                        ));

                        print(_markers);
                      });
                      //   _markers.clear();
                      //   _markers.add(Marker(
                      //       markerId: MarkerId("456"),
                      //       position:
                      //       LatLng(24.9862702, 121.4668569),
                      //       infoWindow: InfoWindow(
                      //         title: "ttt",
                      //         snippet: "台北市",
                      //       ),
                      //       icon: pinLocationIcon));
                      // });
                    },
                    markers: _markers,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          MapLoadingDialogBuilder(context).showLoadingIndicator(loadingTest);
          Position posi = await nowPosition;
          Navigator.of(context).pop();
          setState(() {
            print(posi.latitude);
            print(posi.longitude);
            googleMapController
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(posi.latitude, posi.longitude),
              bearing: 8.0235,
              zoom: 17,
            )));
            _markers.clear();
            _markers.add(Marker(
                onTap: () {
                  showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Notice",
                              overflow: TextOverflow.ellipsis,
                            ),
                            content: Text(
                              "Are you sure to select this place?",
                              // overflow: TextOverflow.ellipsis,
                            ),
                            actions: [
                              FlatButton(
                                textColor: Colors.orangeAccent,
                                onPressed: () async {
                                  List<Placemark> placemark =
                                      await placemarkFromCoordinates(
                                          posi.latitude, posi.longitude);
                                  print("GEOLOCATOR: ${placemark[0]}");
                                  SelectPlace selectPlace = SelectPlace(
                                    allLocation: placemark[0].street,
                                    city: placemark[0].administrativeArea,
                                    district: placemark[0].locality,
                                    no: placemark[0].subAdministrativeArea,
                                    postCode: placemark[0].postalCode,
                                    street: placemark[0].thoroughfare,
                                    latitude: posi.latitude,
                                    longitude: posi.longitude,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context, selectPlace);
                                },
                                child: Text(
                                  "Yes",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: wordsSize_S,
                                  ),
                                ),
                              ),
                              FlatButton(
                                textColor: Colors.grey,
                                onPressed: () {
                                  print("Naci cancel!");
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: wordsSize_S,
                                  ),
                                ),
                              ),
                            ],
                          ));
                },
                markerId: MarkerId("456"),
                position: LatLng(posi.latitude, posi.longitude),
                infoWindow: InfoWindow(
                  title: "I am a current location!",
                  snippet: "台北市",
                ),
                icon: pinLocationIcon));
            print(_markers);
          });
        },
        label: Text('Near Me'),
        backgroundColor: LocationColor,
        icon: Icon(Icons.near_me),
      ),
    );
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}

//GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//           setState(() {
//             _markers["ttt"] = Marker(
//                 markerId: MarkerId("456"),
//                 position: LatLng(20.43296265331129, -122.08832357078792),
//                 infoWindow: InfoWindow(
//                   title: "ttt",
//                   snippet: "台北市",
//
//                 ), icon:pinLocationIcon
//
//             );
//
//             _markers["mmm"] = Marker(
//               markerId: MarkerId("789"),
//               position: LatLng(15.43296265331129, -122.08832357078792),
//               infoWindow: InfoWindow(
//                 title: "mmm",
//                 snippet: "台北市",
//               ),
//
//             );
//           });
//         },
//         markers: _markers.values.toSet(),
//       ),
