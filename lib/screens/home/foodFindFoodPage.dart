import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:animations/animations.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/screens/home/PostEditPage.dart';
import 'package:food_bank_auth/screens/home/PostEditPage_Event.dart';
import 'package:food_bank_auth/screens/home/foodPineapplePage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/findFoodCardList.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class foodFindFoodPage extends StatefulWidget {
  foodFindFoodPage({Key key}) : super(key: key);

  @override
  _foodFindFoodPageState createState() => _foodFindFoodPageState();
}

class _foodFindFoodPageState extends State<foodFindFoodPage> {
  var isMenuOpen = false;
  Future getDataFuture;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  List<String> tagsList_O = []; //list of chosen value
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
                    //title: 'Scrollable List Multiple Choice',
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
                            padding: EdgeInsets.all(4.0),
                            child: _OpenContainerWrapper(
                              foodId: snapshot.data[index].id,
                              photoUrl: snapshot.data[index].photo,
                              title:snapshot.data[index].name,
                              article: snapshot.data[index].introduction,
                              expiredate: snapshot.data[index].best_before_time,
                              foodLocation: "${snapshot.data[index].city} ${snapshot.data[index].district}",
                              transitionType: _transitionType,
                              closedBuilder:
                                  (BuildContext _, VoidCallback openContainer) {
                                return inkWellFoodCardList(
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
  print("getData Foodpage");
  var foodPost;
  DataFetch s = DataFetch();
  foodPost = await s.fetchPostdata();
  print(foodPost);
  return foodPost;
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
    this.photoUrl,
    this.title,
    this.article,
    this.expiredate,
    // this.foodtype,
    this.foodLocation,
    this.foodId
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool> onClosed;
  final String photoUrl;
  final String title;
  final String article;
  final Timestamp expiredate;

  //final String foodtype;
  final String foodLocation;
  final String foodId;

  @override
  Widget build(BuildContext context) {
    var datetime =
    DateTime.fromMicrosecondsSinceEpoch(expiredate.microsecondsSinceEpoch);
    var year = datetime.year;
    var month = datetime.month;
    var day = datetime.day;
    var hour = datetime.hour;
    var minute = datetime.minute;
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return normalFoodArticle(
          foodId: foodId,
          photoUrl: photoUrl,
          article: article,
          expiredate: "${year}・${month}・${day}  ${hour < 10 ? "0" +
              hour.toString() : hour}:${minute < 10
              ? "0" + minute.toString()
              : minute}",
          title: title,
          foodLocation: foodLocation,
        );
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
