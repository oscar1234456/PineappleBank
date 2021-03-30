import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_bank_auth/util/cardSlider.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/dataprocess.dart';
import 'package:geocoding/geocoding.dart';

// import "package:flutter/painting.dart";
import 'dart:ui' as ui;

import 'foodPineapplePage.dart';

class foodFocusPage extends StatefulWidget {
  foodFocusPage();

  @override
  _foodFocusPageState createState() => _foodFocusPageState();
}

class _foodFocusPageState extends State<foodFocusPage> {
  List<dynamic> items = new List();
  Future getDataFuture;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.red, Colors.yellowAccent],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 450.0, 70.0));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 350.0),
                items: [
                  [3, "Hawaiian Pizza"],
                  [10, "Hawaiian Pizza"],
                  [12, "Hawaiian Pizza"]
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return cardSlider(i[0], i[1]);
                    },
                  );
                }).toList(),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //     colors: [Colors.orange, Colors.yellow, Colors.orange]
                          // ),
                          // borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                      child: Text(
                        "   ☆*:.｡. Events .｡.:*☆   ",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient),
                      ),
                    ),
                  )),
              Container(
                height: 300.0,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print("ConnectionDate Done");
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 5.0),
                        decoration: BoxDecoration(
                            // border: new Border.all(color: SaveBtnIconColor_O, width: 1.0),

                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var datetime = DateTime.fromMicrosecondsSinceEpoch(
                                snapshot.data[index].startdate
                                    .microsecondsSinceEpoch);
                            var year = datetime.year;
                            var month = datetime.month;
                            var day = datetime.day;
                            var hour = datetime.hour;
                            var minute = datetime.minute;
                            var diff =
                                DateTime.now().difference(datetime).inHours;
                            var diffDay = (diff / 24).round().abs();

                            var datetime2 = DateTime.fromMicrosecondsSinceEpoch(
                                snapshot.data[index].enddate
                                    .microsecondsSinceEpoch);
                            var year2 = datetime2.year;
                            var month2 = datetime2.month;
                            var day2 = datetime2.day;
                            var hour2 = datetime2.hour;
                            var minute2 = datetime2.minute;

                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.orange[200], width: 2),
                                  borderRadius: BorderRadius.circular(20.0)),
                              elevation: 2.5,
                              child: ListTile(
                                onTap: () async{
                                  List<Placemark> placemark =
                                  await placemarkFromCoordinates(
                                      snapshot.data[index].position.latitude,
                                      snapshot.data[index].position.longitude);

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return normalEventArticle(
                                      photoUrl: snapshot.data[index].photo,
                                      article:
                                          snapshot.data[index].introduction,
                                      title: snapshot.data[index].name,
                                      eventLocation: "${placemark[0].administrativeArea} ${placemark[0].locality}",
                                      startTime: "${year}・${month}・${day}  ${hour < 10 ? "0" + hour.toString() : hour}:${minute < 10 ? "0" + minute.toString() : minute}",
                                      endTime: "${year2}・${month2}・${day2}  ${hour2 < 10 ? "0" + hour2.toString() : hour2}:${minute2 < 10 ? "0" + minute2.toString() : minute2}",
                                    );
                                  }));
                                },
                                focusColor: Colors.green,
                                title: Text(
                                  snapshot.data[index].name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 13,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      width: 3,
                                    ),
                                    Text(
                                      "${year}・${month}・${day}  ${hour < 10 ? "0" + hour.toString() : hour}:${minute < 10 ? "0" + minute.toString() : minute}",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                leading: Container(
                                  width: 50,
                                  height: 70,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        snapshot.data[index].photo.toString()),
                                  ),
                                ),
                                trailing: Text(
                                    "${diffDay == 0 ? "Today" : "After " + diffDay.toString() + " days"}"),
                              ),
                            );
                          },
                          itemCount: snapshot.data.length,
                          // separatorBuilder: (_, __) => Divider(
                          //   height: 0.0,
                          //   thickness: 1.0,
                          //   color: Colors.orange[200],
                          // ),
                        ),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                  future: getDataFuture,
                ),
              ),
            ],
          ),
        ),
        onRefresh: () {
          setState(() {});
          return getDataFuture = getData();
        },
      ),
    );
  }

  Future<List<dynamic>> getData() async {
    print("Get data...");

    var event;
    DataFetch s = DataFetch();
    event = await s.fetchEventdata();
    return event;
  }

  Future<void> re0() async {
    print("RE0");
    setState(() {});
  }

  Future<List<int>> tempS() {
    // simulation for long I/O
    return Future<List<int>>.delayed(Duration(seconds: 2));
  }

// Future<List<dynamic>> getData2() async {
//   items.clear();
//
//   await Future.delayed(Duration(seconds: 2));
//
//     for (int i = 21; i < 30; i++) {
//       items.add(i);
//     }
//   return items;
//
//
}
