import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/dataprocess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:animations/animations.dart';

class generalItem {
  final UserPhoto = Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: ArticleColor,
          shape: BoxShape.circle,
        ),
      ),
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/UserB.png'),
          ),
        ),
      ),
    ],
  );
  final Location = Text(
    "from Pingtung Chaozhou(屏東潮州)", //天涯海角(Location)
    style: TextStyle(
      color: LocationColor,
    ),
  );
  final PinAppJamTitle = Text(
    "Unsalable Pineapple(Cayenne)",
    style: TextStyle(
      color: TitleColor,
    ),
  );
  final PinAppJamArticle = Text(
    "Hand-made Pineapple Apple Jam Ingredients(๑•̀ㅂ•́)و✧\n"
    "\nPineapple Apple Jam Recipe :\n"
    "\nIngredients : ★pineapple(400g)、\napple(150g)、sugar(30g)、lemon briquettes(29ml)\n"
    "\n1. Pineapple with core and apple diced."
    "\n2. Put all the pineapple, apple, sugar, and lemon briquettes into the pot and start cooking on a low heat"
    "\n(It's recommended to use a thicker pot, which will not stick to the pot and burn.)"
    "\n3. Cook until the bubbles are gone and the pulp becomes sticky. After cooling, use a fresh-keeping box or bottle to store and store in the refrigerator."
    "\n\nPineapple in my hometown, Quality Assurance.",
    style: TextStyle(
      color: ArticleColor,
    ),
  );
  final PinPizzaTitle = Text(
    "Hawaiian Pizza",
    style: TextStyle(
      color: TitleColor,
    ),
  );
  final PinPizzaArticle = Text(
    "Hand-made Hawaiian Pizza(๑•̀ㅂ•́)و✧\n"
    "\nCRISPY pie crust and FULL of ingredients",
    style: TextStyle(
      color: ArticleColor,
    ),
  );
}

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
  String participateText = "Participate!";
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    // TODO: implement initState 這裡也是直接複製過來的initState()
    super.initState();
    //getDataFuture = getData();
  }

  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;
    final AppBarCancelBtn = IconButton(
      icon: Icon(
        Icons.west_outlined,
        color: Colors.deepOrange,
        size: ABIconSize,
      ),
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
            //TODO 塞照片 image: Image.network(''),
            image: NetworkImage(widget.photoUrl),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        // child: Text("YOUR TEXT"),
      ),
    );
    final Title = Text(
      "${widget.title}", //TODO 塞標題
      style: TextStyle(
        color: TitleColor,
      ),
    );
    final Article = Text(
      "${widget.article}", //TODO 塞內文
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
                          "Start ", //TODO ${時間}
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
                          "${widget.startTime}", //TODO ${時間}
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
                          "  End ", //TODO ${時間}
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
                          "${widget.endTime}", //TODO ${時間}
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
              leading: generalItem().UserPhoto,
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
                  style: ElevatedButton.styleFrom(
                    primary: TagBG, // background
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
    final AtdBtn = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                "look forward to your visit (๑・ω-)～♡",
                style: TextStyle(
                  color: ArticleColor,
                ),
              ),
              actions: [
                FlatButton(
                  textColor: Colors.orange,
                  onPressed: () {
                    setState(() {
                      participateText = "Cancel Participation!";
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "I see.",
                    style: TextStyle(
                      fontSize: wordsSize_S,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
        label: Text(
          participateText,
          style: TextStyle(
            color: SaveBtnIconColor,
          ),
        ),
        icon: Icon(
          Icons.grade,
          color: SaveBtnIconColor,
        ),
        color: SaveBtnColor,
      ),
    );
    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          "Event",
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

  normalFoodArticle({
    Key key,
    @required this.file,
    @required this.title,
    @required this.article,
    @required this.expiredate,
    @required this.foodtype,
    @required this.photoUrl,
    @required this.foodLocation,
  }) : super(key: key);

  @override
  _normalFoodArticleState createState() => _normalFoodArticleState();
}

class _normalFoodArticleState extends State<normalFoodArticle> {
  var MarkBtnText = MarkText;
  var Markicon = Icons.bookmark_border;
  var Markcolor = MarkBtnColor_X;
  var MarkiconColor = MarkBtnIconColor_X;
  var isMarked = false;

  @override
  void initState() {
    super.initState();
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
                          "Expire Date ", //TODO ${時間}
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
                          "${widget.expiredate}", //TODO ${時間}
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
      icon: Icon(
        Icons.west_outlined,
        color: Colors.deepOrange,
        size: ABIconSize,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final SaveFoodBtn = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(SaveCheck_t),
                    content: Text(SaveCheck_c),
                    actions: [
                      FlatButton(
                        //Cancel
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Save_X,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                      FlatButton(
                        //Yes
                        textColor: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                      SucceedText,
                                      style: TextStyle(
                                        color: ArticleColor,
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        //Cancel
                                        textColor: Colors.orange,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          // Navigator.pop(context);
                                        },
                                        child: Text(
                                          Save_X,
                                          style: TextStyle(
                                            fontSize: wordsSize_S,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: Text(
                          Save_O,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                    ],
                  ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
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
        color: SaveBtnColor,
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
        // child: Text("YOUR TEXT"),
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
              title: Title,
              subtitle: Text(
                "from ${widget.foodLocation}", //天涯海角(Location)
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
                )),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isMarked = !isMarked;
                      MarkBtnText = isMarked ? MarkedText : MarkText;
                      Markicon =
                          isMarked ? Icons.bookmark : Icons.bookmark_border;
                      Markcolor = isMarked ? MarkBtnColor_O : MarkBtnColor_X;
                      MarkiconColor =
                          isMarked ? MarkBtnIconColor_O : MarkBtnIconColor_X;
                    });
                  },
                  icon: Icon(
                    Markicon,
                    color: MarkiconColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Markcolor, // backgroundColor
                  ),
                  label: Text(
                    MarkBtnText,
                    style: TextStyle(
                      color: MarkiconColor,
                    ),
                  ),
                ),
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
                  style: ElevatedButton.styleFrom(
                    primary: TagBG, // background
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
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          ABText,
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

//首頁PIZZA(死的)
class foodPineapplePage extends StatefulWidget {
  @override
  _foodPineapplePageState createState() => _foodPineapplePageState();
}

class _foodPineapplePageState extends State<foodPineapplePage> {
  var MarkBtnText = MarkText;
  var Markicon = Icons.bookmark_border;
  var Markcolor = MarkBtnColor_X;
  var MarkiconColor = MarkBtnIconColor_X;
  var isMarked = false;

  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;
    final AppBarCancelBtn = IconButton(
      icon: Icon(
        Icons.west_outlined,
        color: Colors.deepOrange,
        size: ABIconSize,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final SaveFoodBtn = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(SaveCheck_t),
                    content: Text(SaveCheck_c),
                    actions: [
                      FlatButton(
                        //Cancel
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Save_X,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                      FlatButton(
                        //Yes
                        textColor: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                      SucceedText,
                                      style: TextStyle(
                                        color: ArticleColor,
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        //Cancel
                                        textColor: Colors.orange,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          Save_X,
                                          style: TextStyle(
                                            fontSize: wordsSize_S,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: Text(
                          Save_O,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                    ],
                  ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
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
        color: SaveBtnColor,
      ),
    );
    final foodPhoto = Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        height: MediaQuery.of(context).size.width * 8 / 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/foodPizzaPhoto2.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        // child: Text("YOUR TEXT"),
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
              title: generalItem().PinPizzaTitle,
              subtitle: generalItem().Location,
            ),
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: generalItem().PinPizzaArticle,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isMarked = !isMarked;
                      MarkBtnText = isMarked ? MarkedText : MarkText;
                      Markicon =
                          isMarked ? Icons.bookmark : Icons.bookmark_border;
                      Markcolor = isMarked ? MarkBtnColor_O : MarkBtnColor_X;
                      MarkiconColor =
                          isMarked ? MarkBtnIconColor_O : MarkBtnIconColor_X;
                    });
                  },
                  icon: Icon(
                    Markicon,
                    color: MarkiconColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Markcolor, // backgroundColor
                  ),
                  label: Text(
                    MarkBtnText,
                    style: TextStyle(
                      color: MarkiconColor,
                    ),
                  ),
                ),
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
                  style: ElevatedButton.styleFrom(
                    primary: TagBG, // background
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
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          ABText,
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
          foodPhoto,
          SizedBox(height: Height_Size_L),
          foodContent,
          SizedBox(height: Height_Size_L * 3),
        ],
      ),
      floatingActionButton: SaveFoodBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//已marked的鳳梨食譜貼文(死的)
class foodArticlePage extends StatefulWidget {
  @override
  _foodArticlePageState createState() => _foodArticlePageState();
}

class _foodArticlePageState extends State<foodArticlePage> {
  var MarkBtnText = MarkedText;
  var Markicon = Icons.bookmark;
  var Markcolor = MarkBtnColor_O;
  var MarkiconColor = MarkBtnIconColor_O;
  var isSaved = true;

  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;
    final AppBarCancelBtn = IconButton(
      icon: Icon(
        Icons.west_outlined,
        color: Colors.deepOrange,
        size: ABIconSize,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final SaveFoodBtn = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(SaveCheck_t),
                    content: Text(SaveCheck_c),
                    actions: [
                      FlatButton(
                        //Cancel
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Save_X,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                      FlatButton(
                        //Yes
                        textColor: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                      SucceedText,
                                      style: TextStyle(
                                        color: ArticleColor,
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        //Cancel
                                        textColor: Colors.orange,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          Save_X,
                                          style: TextStyle(
                                            fontSize: wordsSize_S,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        child: Text(
                          Save_O,
                          style: TextStyle(
                            fontSize: wordsSize_S,
                          ),
                        ),
                      ),
                    ],
                  ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
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
        color: SaveBtnColor,
      ),
    );
    final foodPhoto = Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 8 / 10,
        height: MediaQuery.of(context).size.width * 8 / 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/foodPizzaPhoto.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        // child: Text("YOUR TEXT"),
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
              title: generalItem().PinAppJamTitle,
              subtitle: generalItem().Location,
            ),
            Padding(
              padding: EdgeInsets.all(RaisedButtonborderRadius),
              child: generalItem().PinAppJamArticle,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                      MarkBtnText = isSaved ? MarkedText : MarkText;
                      Markicon =
                          isSaved ? Icons.bookmark : Icons.bookmark_border;
                      Markcolor = isSaved ? MarkBtnColor_O : MarkBtnColor_X;
                      MarkiconColor =
                          isSaved ? MarkBtnIconColor_O : MarkBtnIconColor_X;
                    });
                  },
                  icon: Icon(
                    Markicon,
                    color: MarkiconColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Markcolor, // backgroundColor
                  ),
                  label: Text(
                    MarkBtnText,
                    style: TextStyle(
                      color: MarkiconColor,
                    ),
                  ),
                ),
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
                  style: ElevatedButton.styleFrom(
                    primary: TagBG, // background
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
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          ABText,
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
          foodPhoto,
          SizedBox(height: Height_Size_L),
          foodContent,
          SizedBox(height: Height_Size_L * 3),
        ],
      ),
      floatingActionButton: SaveFoodBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
