import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/place.dart';
import 'package:food_bank_auth/util/mapLoadingDialog.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
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
    final WindowW = MediaQuery.of(context).size.width;
    final bodyH = MediaQuery.of(context).size.height - 56; //56為預設AppBar高度
    print("Now in build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Select your Place"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: bodyH,
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
                                TextButton(
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
                                      color: Colors.orangeAccent,
                                      fontSize: NormalWordsSize,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Naci cancel!");
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: NormalWordsSize,
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
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            left: 50.0,
            right: 20.0,
            top: 100.0,
            child: SearchMapPlaceWidget(
              iconColor: InputCursorColor,
              apiKey: "<Your API KEY>",
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
          ),
          Positioned(
            left: WindowW / 2 - WindowW * 1 / 7 + 20.0,
            bottom: 30.0,
            child: Container(
              width: WindowW * 2 / 7,
              child: FloatingActionButton.extended(
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
                                  TextButton(
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
                                        color: Colors.orangeAccent,
                                        fontSize: NormalWordsSize,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      print("Naci cancel!");
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: NormalWordsSize,
                                        color: Colors.grey,
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
                backgroundColor: LocationColor,
                label: Text('Near Me', style: TextStyle(color: Colors.white70,),),
                icon: Icon(Icons.near_me,color: Colors.white70,),
              ),
            ),
          ),
        ],
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
