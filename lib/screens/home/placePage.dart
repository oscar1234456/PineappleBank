import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/mapLoadingDialog.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:geolocator/geolocator.dart';

class placePage extends StatefulWidget {
  @override
  State<placePage> createState() => placePageState();
}

class placePageState extends State<placePage> {
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
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    // pinLocationIcon
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.9861783, 121.4667732),
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
    final bodyH = MediaQuery.of(context).size.height - 116.0;// AppBar(56) + BottomBar(60)
    print("Now in build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Places"),
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
              var tempList = await getData();
              Position posi = await nowPosition;
              Navigator.of(context).pop();
              setState(() {
                print("in onMapCreated setState");
                print(posi);
                _markers.add(Marker(
                  markerId: MarkerId("789"),
                  position: LatLng(posi.latitude, posi.longitude),
                  infoWindow: InfoWindow(
                    title: "I am a current location!",
                    snippet: "新北市",
                  ),
                    icon: pinLocationIcon,
                ));
                var i= 0 ;
                tempList.forEach((element) {
                  _markers.add(Marker(
                    markerId: MarkerId("${i}"),
                    position: LatLng(element.position.latitude, element.position.longitude),
                    infoWindow: InfoWindow(
                      title: element.name,
                      snippet: element.city,
                    ),
                  ));
                  i+=1;
                });
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
              hasClearButton: true,
              apiKey: "<Your API KEY>",
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
                  var tempList = await getData();
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
                        markerId: MarkerId("456"),
                        position: LatLng(posi.latitude, posi.longitude),
                        infoWindow: InfoWindow(
                          title: "I am a current location!",
                          snippet: "台北市",
                        ),
                        icon: pinLocationIcon));
                    var i= 0 ;
                    tempList.forEach((element) {
                      _markers.add(Marker(
                        markerId: MarkerId("${i}"),
                        position: LatLng(element.position.latitude, element.position.longitude),
                        infoWindow: InfoWindow(
                          title: element.name,
                          snippet: element.city,
                        ),
                      ));
                      i+=1;
                    });
                    print(_markers);
                  });
                },
                backgroundColor: LocationColor,
                label: Text('Near Me',style: TextStyle(color: Colors.white70,),),
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

Future<List<dynamic>> getData() async {
  print("getData Eventpage");
  var event;
  DataFetch s = DataFetch();
  event = await s.fetchEventdata();
  return event;
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
