import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/presetItem.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:http/http.dart' as http;

//TODO : 直接複製過來的東東
Future<List<dynamic>> getData() async {
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

//一般活動貼文
class normalEventArticle extends StatefulWidget {
  final File file;
  final String title;
  final String article;
  final String startTime;
  final String endTime;
  final List foodtype;
  final String photoUrl;
  final String eventLocation;

  normalEventArticle(
      {Key key,
      this.file,
      this.title,
      this.article,
      this.startTime,
      this.endTime,
      this.foodtype,
      this.photoUrl,
      this.eventLocation})
      : super(key: key);

  @override
  _normalEventArticleState createState() => _normalEventArticleState();
}
class _normalEventArticleState extends State<normalEventArticle> {
  Future getDataFuture;
  // String _userName ;
  // String _userPhoto ;
  var participate = false;
  var Staricon = partiBtnIcon[0];
  var participateText = attendEventORnot[1];
  var PartiDialogText = attendEventORcancel[1];

  @override
  void initState() {
    // TODO: implement initState 這裡也是直接複製過來的initState()
    super.initState();
  }

  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;
    final AppBarCancelBtn = IconButton(
      icon: BackIcon,
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final Photo = Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        height: MediaQuery.of(context).size.width * 8 / 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.photoUrl),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        // child: Text("YOUR TEXT"),
      ),
    );
    final Title = Text(
      "${widget.title}",
      style: TextStyle(
        color: TitleColor,
      ),
    );
    final Article = Text(
      "${widget.article}",
      style: TextStyle(
        color: ArticleColor,
      ),
    );
    final Time = Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "Start ",
                          style: TextStyle(
                              color: ArticleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "${widget.startTime}",
                          style: TextStyle(
                            color: ArticleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "  End ",
                          style: TextStyle(
                              color: ArticleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "${widget.endTime}",
                          style: TextStyle(
                            color: ArticleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final foodContent = Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        child: Column(
          children: [
            ListTile(
              leading: generalItem().UserPhoto,//For test
              // leading: Stack(
              //   alignment: Alignment.center,
              //   children: <Widget>[
              //     Container(
              //       width: 50,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: ArticleColor,
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //     Container(
              //       width: 45,
              //       height: 45,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           fit: BoxFit.fill,
              //           image: NetworkImage(_userPhoto),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              title: Title,
              subtitle: Text(
                "from ${widget.eventLocation}", //天涯海角(Location)
                style: TextStyle(
                  color: LocationColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: Article,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      //TODO show the map
                    });
                  },
                  icon: Icon(
                    Icons.map_rounded,
                    color: ButtonIconColor,
                  ),
                  // style: ElevatedButton.styleFrom(
                  //   primary: TagBG, // background
                  // ),
                  label: Text(
                    "Check the Map",
                    style: TextStyle(color: ButtonIconColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    final AtdBtn = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                PartiDialogText,
                style: DiaConStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      participate = !participate;
                      participateText = participate? attendEventORnot[0]: attendEventORnot[1];
                      Staricon = participate? partiBtnIcon[1]: partiBtnIcon[0];
                      PartiDialogText = participate? attendEventORcancel[0]: attendEventORcancel[1];
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    OKoptionText,
                    style: DiaOptStyle,
                  ),
                ),
              ],
            ),
          );
        },
        label: Text(
          participateText,
          style: TextStyle(
            color: SaveBtnIconColor,
          ),
        ),
        icon: Staricon,
        style: SaveBtnDesign,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          "${widget.title}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: paddingNum,
          horizontal: paddingNum,
        ),
        children: <Widget>[
          Photo,
          SizedBox(height: Height_Size_L),
          Time,
          SizedBox(height: Height_Size_L),
          foodContent,
          SizedBox(height: Height_Size_L * 3),
        ],
      ),
      floatingActionButton: AtdBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//一般食物貼文
class normalFoodArticle extends StatefulWidget {
  final File file;
  final String title;
  final String article;
  final String expiredate;
  final List foodtype;
  final String photoUrl;
  final String foodLocation;
  final String foodId;

  normalFoodArticle({
    Key key,
    @required this.file,
    @required this.title,
    @required this.article,
    @required this.expiredate,
    @required this.foodtype,
    @required this.photoUrl,
    @required this.foodLocation,
    @required this.foodId,
  }) : super(key: key);

  @override
  _normalFoodArticleState createState() => _normalFoodArticleState();
}
class _normalFoodArticleState extends State<normalFoodArticle> {
  // var MarkBtnText = MarkText;
  // var Markicon = Icons.bookmark_border;
  // var Markcolor = MarkBtnColor_X;
  // var MarkiconColor = MarkBtnIconColor_X;
  var isMarked = false;
  // String _userName ;
  // String _userPhoto ;
  @override
  void initState() {
    super.initState();
    print("foodId: ${widget.foodId}");
  }

  @override
  Widget build(context) {
    final Time = Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "Expire Date ",
                          style: TextStyle(
                              color: ArticleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Baseline(
                        baseline: 15,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          "${widget.expiredate}",
                          style: TextStyle(
                            color: ArticleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final paddingNum = MediaQuery.of(context).size.width / 14;
    final AppBarCancelBtn = IconButton(
      icon: BackIcon,
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final SaveFoodBtn = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () {
          //TODO 比對id (修完直接解放(?)if/else的註解就可以惹 AlertDialog已就位OuO )
          // if(poster_id!=user_id){
          showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  SaveCheck_t,
                  style: DiaTitleStyle,
                ),
                content: Text(
                  SaveCheck_c,
                  style: DiaConStyle,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      Save_X,
                      style: DiaOptDesign[0],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      Save_O,
                      style: DiaOptDesign[1],
                    ),
                    onPressed: () async{
                      //This is a position user finish save food process
                      //TODO:firebase upgrade
                      UpdateData updata = UpdateData();
                      await updata.updateUserSavePost(widget.foodId);
                      Navigator.pop(context);
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                            SucceedText,
                            style: DiaConStyle,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                OKoptionText,
                                style: DiaOptStyle,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
          );
          // }else{
          // showDialog<void>(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //       title: Text(
          //         YourOwnFoodText[0],
          //         style: DiaTitleStyle,
          //       ),
          //       content: Text(
          //         YourOwnFoodText[1],
          //         style: DiaConStyle,
          //       ),
          //       actions: [
          //         TextButton(
          //           child: Text(
          //             OKoptionText,
          //             style: DiaOptDesign[1],
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //         ),
          //       ],
          //     )
          // );
          // }
        },
        label: Text(
          SaveBtn,
          style: TextStyle(
            color: SaveBtnIconColor,
          ),
        ),
        icon: Icon(
          Icons.favorite_rounded,
          color: SaveBtnIconColor,
        ),
        style: SaveBtnDesign,
      ),
    );
    final foodPhoto = Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        height: MediaQuery.of(context).size.width * 8 / 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.photoUrl),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
    );
    final Title = Text(
      widget.title,
      style: TextStyle(
        color: TitleColor,
      ),
    );
    final foodContent = Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        child: Column(
          children: [
            ListTile(
              leading: generalItem().UserPhoto,
              // leading: Stack(
              //   alignment: Alignment.center,
              //   children: <Widget>[
              //     Container(
              //       width: 50,
              //       height: 50,
              //       decoration: BoxDecoration(
              //         color: ArticleColor,
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //     Container(
              //       width: 45,
              //       height: 45,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         image: DecorationImage(
              //           fit: BoxFit.fill,
              //           image: NetworkImage(_userPhoto),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              title: Title,
              subtitle: Text(
                "from ${widget.foodLocation}",
                style: TextStyle(
                  color: LocationColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: Text(
                widget.article,
                style: TextStyle(
                  color: ArticleColor,
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                // ElevatedButton.icon(
                //   onPressed: () {
                //     setState(() {
                //       isMarked = !isMarked;
                //       MarkBtnText = isMarked ? MarkedText : MarkText;
                //       Markicon = isMarked ? Icons.bookmark : Icons.bookmark_border;
                //       Markcolor = isMarked ? MarkBtnColor_O : MarkBtnColor_X;
                //       MarkiconColor = isMarked ? MarkBtnIconColor_O : MarkBtnIconColor_X;
                //     });
                //   },
                //   icon: Icon(
                //     Markicon,
                //     color: MarkiconColor,
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: Markcolor, // backgroundColor
                //   ),
                //   label: Text(
                //     MarkBtnText,
                //     style: TextStyle(
                //       color: MarkiconColor,
                //     ),
                //   ),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      //TODO show the map
                    });
                  },
                  icon: Icon(
                    Icons.map_rounded,
                    color: ButtonIconColor,
                  ),
                  label: Text(
                    "Check the Map",
                    style: TextStyle(color: ButtonIconColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          "${widget.title}",
          style: WhiteTextDesign,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: paddingNum,
          horizontal: paddingNum,
        ),
        children: <Widget>[
          foodPhoto,
          SizedBox(height: Height_Size_L),
          Time,
          SizedBox(height: Height_Size_L),
          foodContent,
          SizedBox(height: Height_Size_L),
          SizedBox(height: Height_Size_L),
          SizedBox(height: Height_Size_L),
        ],
      ),
      floatingActionButton: SaveFoodBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}