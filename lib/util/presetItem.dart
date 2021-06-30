import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'dart:math';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';
//
//死的部件不維護(很肥)
//
class generalItem {//預設屬性
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
            image: AssetImage('images/UserA.png'),
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
//首頁PIZZA(死的)
class foodPineapplePage extends StatefulWidget{
  @override
  _foodPineapplePageState createState() => _foodPineapplePageState();
}
class _foodPineapplePageState extends State<foodPineapplePage> {
  var isMarked = false;
  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width/14;
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
          showDialog<void>(context: context, builder: (context) => AlertDialog(
            title: Text(SaveCheck_t),
            content: Text(SaveCheck_c),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(Save_X,
                  style: TextStyle(
                    fontSize: NormalWordsSize,
                    color: Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog<void>(context: context, builder: (context) => AlertDialog(
                    content: Text(SucceedText,
                      style: TextStyle(
                        color: ArticleColor,
                      ),
                    ),
                    actions: [
                      FlatButton(//Cancel
                        textColor: Colors.orange,
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(Save_X,
                          style: TextStyle(
                            fontSize: NormalWordsSize,
                          ),
                        ),
                      ),
                    ],
                  ));
                },
                child: Text(Save_O,
                  style: TextStyle(
                    fontSize: NormalWordsSize,
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
        label: Text(SaveBtn,
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
    final foodPhoto =  Card(
      child: Container(
        width: MediaQuery.of(context).size.width*8/10,
        height: MediaQuery.of(context).size.width*8/10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(PizzaBrownBGImgPath),
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
        width: MediaQuery.of(context).size.width*8/10,
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.map_rounded,
                    color: ButtonIconColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent[100], // background
                  ),
                  label: Text(
                    "Check the Map",
                    style: TextStyle(
                        color: ButtonIconColor
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      // backgroundColor: BGColor,
      appBar: AppBar(
        // backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text("Save the food!!",
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
          SizedBox(height:Height_Size_L),
          foodContent,
          SizedBox(height:Height_Size_L*3),
        ],
      ),
      floatingActionButton: SaveFoodBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
//History的鳳梨食譜貼文(死的)
class foodArticlePage extends StatefulWidget{
  @override
  _foodArticlePageState createState() => _foodArticlePageState();
}
class _foodArticlePageState extends State<foodArticlePage> {
  // var MarkBtnText = MarkedText;
  // var Markicon = Icons.bookmark;
  // var Markcolor = MarkBtnColor_O;
  // var MarkiconColor = MarkBtnIconColor_O;
  var isSaved = true;
  @override
  Widget build(context) {
    final paddingNum = MediaQuery.of(context).size.width/14;
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
    // final SaveFoodBtn = Container(
    //   height: SettingButton_Height,
    //   child: TextButton.icon(
    //     onPressed: () {
    //       showDialog<void>(context: context, builder: (context) => AlertDialog(
    //         title: Text(SaveCheck_t),
    //         content: Text(SaveCheck_c),
    //         actions: [
    //           TextButton(
    //             onPressed: (){
    //               Navigator.pop(context);
    //             },
    //             child: Text(Save_X,
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: NormalWordsSize,
    //               ),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               showDialog<void>(context: context, builder: (context) => AlertDialog(
    //                 content: Text(
    //                   SucceedText,
    //                   style: DiaConStyle,
    //                 ),
    //                 actions: [
    //                   TextButton(
    //                     onPressed: (){
    //                       Navigator.pop(context);
    //                       Navigator.pop(context);
    //                       Navigator.pop(context);
    //                     },
    //                     child: Text(Save_X,
    //                       style: TextStyle(
    //                         color: Colors.orange,
    //                         fontSize: NormalWordsSize,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ));
    //             },
    //             child: Text(Save_O,
    //               style: TextStyle(
    //                 fontSize: NormalWordsSize,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ));
    //     },
    //     style: ButtonStyle(
    //         backgroundColor: MaterialStateProperty.all<Color>(SaveBtnColor),
    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //             RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(RaisedButtonborderRadius),
    //             )
    //         )
    //     ),
    //     label: Text(SaveBtn,
    //       style: TextStyle(
    //         color: SaveBtnIconColor,
    //       ),
    //     ),
    //     icon: Icon(
    //       Icons.favorite_rounded,
    //       color: SaveBtnIconColor,
    //     ),
    //   ),
    // );
    final foodPhoto =  Card(
      child: Container(
        width: MediaQuery.of(context).size.width*8/10,
        height: MediaQuery.of(context).size.width*8/10,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ManyPineImgPath),
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
        width: MediaQuery.of(context).size.width*8/10,
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
                // ElevatedButton.icon(
                //   onPressed: () {
                //     setState(() {
                //       isSaved = !isSaved;
                //       MarkBtnText = isSaved ? MarkedText : MarkText;
                //       Markicon = isSaved ? Icons.bookmark : Icons.bookmark_border;
                //       Markcolor = isSaved ? MarkBtnColor_O : MarkBtnColor_X;
                //       MarkiconColor = isSaved ? MarkBtnIconColor_O : MarkBtnIconColor_X;
                //     });
                //   },
                //   icon: Icon(
                //     Markicon,
                //     color: MarkiconColor,
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: Markcolor, // backgroundColor
                //   ),
                //   label: Text(MarkBtnText,
                //     style: TextStyle(
                //       color: MarkiconColor,
                //     ),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     setState(() {
                //       //show the map
                //     });
                //   },
                //   icon: Icon(
                //     Icons.map_rounded,
                //     color: ButtonIconColor,
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.orangeAccent[100], // background
                //   ),
                //   label: Text(
                //     "Check the Map",
                //     style: TextStyle(
                //         color: ButtonIconColor
                //     ),
                //   ),
                // ),
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
          "Unsalable Pineapple",
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
          SizedBox(height:Height_Size_L),
          foodContent,
          SizedBox(height:Height_Size_L*3),
        ],
      ),
      // floatingActionButton: SaveFoodBtn,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
//HistoryPage(死的)
class ConedItem extends StatefulWidget{
  @override
  _ConedItemState createState() => _ConedItemState();
}
class _ConedItemState extends State<ConedItem> {
  final foodPhoto = [
    // IronEggImgPath,//鐵蛋
    // BubbleMilkTeaImgPath,//珍珠奶茶
    ManyPineImgPath,//鳳梨
  ];
  final foodName = [
    // "iron egg",//鐵蛋
    // "bubble milk tea",//珍珠奶茶
    "Unsalable Pineapple"//鳳梨
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), //加上一層透明0.7的黑
                BlendMode.dstATop //混合模式，放到上面去
            ),
            image: AssetImage(foodPhoto[0]),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              // leading: Icon(Icons.person,color: Colors.grey,),
              title: Text(
                foodName[0],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in Pingtung......'
                '\nDate:2021/04/13',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFFb87333)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => foodArticlePage())
                    );
                  },
                  child: Text(
                    'see more...',
                    style: TextStyle(
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class presetConedPage extends StatelessWidget {
  List _list = List.generate(4, (index) {
    return index;
  });
  List<Widget> _getGridList() {
    return _list.map((item) {
      return ConedItem();
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text("Your Food Post Trace",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.count(
        children: _getGridList(),
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10, // 水平距离
        mainAxisSpacing: 10, // 垂直距离
        childAspectRatio: 10/10, // 宽高比例
      ),
    );
  }
}
//SavedPage(死的)
class savedItem extends StatelessWidget {
  int foodNum = Random().nextInt(6);
  int dateDay = Random().nextInt(27);
  final foodPhoto = [
    IronEggImgPath,//鐵蛋
    BubbleMilkTeaImgPath,//珍珠奶茶
    WheelPiestaroImgPath,//芋頭車輪餅
    WheelPiespeanutImgPath,//花生車輪餅
    WheelPiescreamImgPath,//奶油車輪餅
    WheelPiesredbeanImgPath,//紅豆車輪餅
  ];
  final foodName = [
    "iron egg",//鐵蛋
    "bubble milk tea",//珍珠奶茶
    "wheel pies(taro)",//芋頭車輪餅
    "wheel pies(peanut)",//花生車輪餅
    "wheel pies(cream)",//奶油車輪餅
    "wheel pies(red bean)",//紅豆車輪餅
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), //加上一層透明0.5的黑
                BlendMode.dstATop //混合模式，放到上面去
            ),
            image: AssetImage(foodPhoto[foodNum]),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                foodName[foodNum],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in Taipei'
                '\nDate:2021/02/${dateDay}'
                '\nGet Point : 5'
                '\n\n(Reliability=Point*0.1) ',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFFb87333)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class presetSavedPage extends StatelessWidget {
  List _list = List.generate(8, (index) {
    return index;
  });
  List<Widget> _getGridList() {
    return _list.map((item) {
      return savedItem();
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text(
          "The saved food",
          style: WhiteTextDesign,
        ),
      ),
      body: GridView.count(
        children: _getGridList(),
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10, // 水平距离
        mainAxisSpacing: 10, // 垂直距离
        childAspectRatio: 10/10, // 宽高比例
      ),
    );
  }
}