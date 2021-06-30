import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:animations/animations.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import "package:food_bank_auth/services/dataprocess.dart";
import 'package:food_bank_auth/screens/home/PostEditPage.dart';
import 'package:food_bank_auth/screens/home/PostEditPage_Event.dart';
import 'package:food_bank_auth/screens/home/foodPineapplePage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/findEventCardList.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class foodFindEventPage extends StatefulWidget {
  foodFindEventPage({Key key}) : super(key: key);

  @override
  _foodFindEventPageState createState() => _foodFindEventPageState();
}

class _foodFindEventPageState extends State<foodFindEventPage> {
  var isMenuOpen = false;
  Future getDataFuture;
  List<String> tagsList_O = []; //list of chosen value
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFuture = getData();
  }

  void _showMarkedAsDoneSnackbar(bool isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final AddEvent = RawMaterialButton(
      fillColor: AddEventBtnColor,
      shape: CircleBorder(),
      padding: EdgeInsets.all(20.0),
      child: AddEvent_Icon,
      onPressed: () async{
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostEditPage_Event()));
      },
    );
    final AddFood = RawMaterialButton(
      fillColor: AddEventBtnColor,
      shape: CircleBorder(),
      padding: EdgeInsets.all(20.0),
      child: Icon(
        Icons.fastfood_rounded,
        color: AddEventBtnIconColor,
      ),
      onPressed: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostEditPage())
        );
      },
    );
    final CloseBtnList = RawMaterialButton(
      fillColor: Pineapple300,
      shape: CircleBorder(),
      child: CloseBtnList_Icon,
      onPressed: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
    );
    final AddList = Stack(
      children: <Widget>[
        Positioned( //Visibility
          child: Visibility(
            visible: isMenuOpen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AddEvent,
                SizedBox(height:Height_Size_L),
                AddFood,
                SizedBox(height:Height_Size_L),
                CloseBtnList,
              ],
            ),
          ),
        ),
        Positioned( //Visibility
          child: Visibility(
            visible: !isMenuOpen,
            child: FloatingActionButton(
              backgroundColor: Colors.orangeAccent,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              },
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                children: <Widget>[
                  Content(
                    child: ChipsChoice<String>.multiple(
                      value: tagsList_O,
                      onChanged: (val) => setState(() => tagsList_O = val),
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: tagsList,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black54,
              ),
              onPressed: () => {}),
        ],
        backgroundColor: Pineapple50,
        elevation: 0.0,
      ),
      floatingActionButton: AddList,
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return getDataFuture = getData();
        },
        child: Center(
          child: Container(
            child: FutureBuilder(
              future: getDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print(snapshot.data);
                  return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: _OpenContainerWrapper(
                              title: snapshot.data[index].name,
                              photoUrl: snapshot.data[index].photo,
                              article: snapshot.data[index].introduction,
                              startTime: snapshot.data[index].startdate,
                              endTime: snapshot.data[index].enddate,
                              eventLocation: "${snapshot.data[index].city} ${snapshot.data[index].district}",
                              transitionType: _transitionType,
                              closedBuilder:
                                  (BuildContext _, VoidCallback openContainer) {
                                return inkWellEventCardList(
                                    openContainer: openContainer,
                                    data: snapshot.data[index]);
                              },
                              onClosed: _showMarkedAsDoneSnackbar,
                            ));
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<dynamic>> getData() async {
  print("getData Eventpage");
  var event;
  DataFetch s = DataFetch();
  event = await s.fetchEventdata();
  return event;
}

Future<List<String>> fetchGalleryData() async {
  try {
    final response = await http
        .get(
            'https://kaleidosblog.s3-eu-west-1.amazonaws.com/flutter_gallery/data.json')
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return compute(parseGalleryData, response.body);
    } else {
      throw Exception('Failed to load');
    }
  } on SocketException catch (e) {
    throw Exception('Failed to load');
  }
}

List<String> parseGalleryData(String responseBody) {
  final parsed = List<String>.from(json.decode(responseBody));
  return parsed;
}

Future<Null> getShowImage() async {}

//HashTag
class Content extends StatefulWidget {
  final Widget child;

  Content({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content>
    with AutomaticKeepAliveClientMixin<Content> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      color: Pineapple50,
      elevation: 0.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    @required this.closedBuilder,
    @required this.transitionType,
    @required this.onClosed,
    @required this.photoUrl,
    @required this.article,
    @required this.title,
    @required this.eventLocation,
    @required this.startTime,
    @required this.endTime,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool> onClosed;
  final String photoUrl;
  final String article;
  final String title;
  final String eventLocation;
  final Timestamp startTime;
  final Timestamp endTime;

  @override
  Widget build(BuildContext context) {
    var datetime =
        DateTime.fromMicrosecondsSinceEpoch(startTime.microsecondsSinceEpoch);
    var year = datetime.year;
    var month = datetime.month;
    var day = datetime.day;
    var hour = datetime.hour;
    var minute = datetime.minute;
    var datetime2 = DateTime.fromMicrosecondsSinceEpoch(
        endTime
            .microsecondsSinceEpoch);
    var year2 = datetime2.year;
    var month2 = datetime2.month;
    var day2 = datetime2.day;
    var hour2 = datetime2.hour;
    var minute2 = datetime2.minute;
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return normalEventArticle(
          photoUrl: photoUrl,
          article: article,
          title: title,
          // eventLocation: "${snapshot.data[0].administrativeArea} ${snapshot.data[0].locality}",
          eventLocation: eventLocation,
          startTime: "${year}・${month}・${day}  ${hour < 10 ? "0" +
              hour.toString() : hour}:${minute < 10
              ? "0" + minute.toString()
              : minute}",
          endTime: "${year2}・${month2}・${day2}  ${hour2 < 10 ? "0" +
              hour2.toString() : hour2}:${minute2 < 10 ? "0" +
              minute2.toString() : minute2}",
        );
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
