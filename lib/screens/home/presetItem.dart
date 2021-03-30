import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/foodPineapplePage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'dart:math';

//ConsideredPage
class ConedItem extends StatefulWidget{
  @override
  _ConedItemState createState() => _ConedItemState();
}
class _ConedItemState extends State<ConedItem> {
  int foodNum = Random().nextInt(3);
  int dateDay = Random().nextInt(27);
  final foodPhoto = [
    "images/presetIronEgg.png",//鐵蛋
    "images/presetBubbleMilkTea.png",//珍珠奶茶
    "images/foodPizzaPhoto.png"//鳳梨
  ];
  final foodName = [
    "iron egg",//鐵蛋
    "bubble milk tea",//珍珠奶茶
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
              // leading: Icon(Icons.person,color: Colors.grey,),
              title: Text(
                foodName[foodNum],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in Pingtung......'
                '\nDate:2021/04/${dateDay}'
                '\nHand-made......',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFFb87333)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  textColor: Colors.brown,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => foodArticlePage())
                    );
                  },
                  child: Text('see more...'),
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
  List _list = List.generate(8, (index) {
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
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text("The Considered food",
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
        childAspectRatio: 9/10, // 宽高比例
      ),
    );
  }
}

//SavedPage
class savedItem extends StatelessWidget {
  int foodNum = Random().nextInt(6);
  int dateDay = Random().nextInt(27);
  final foodPhoto = [
    "images/presetIronEgg.png",//鐵蛋
    "images/presetBubbleMilkTea.png",//珍珠奶茶
    "images/WheelPies_Taro.png",//芋頭車輪餅
    "images/WheelPies_Peanut.png",//花生車輪餅
    "images/WheelPies_Cream.png",//奶油車輪餅
    "images/WheelPies_RedBean.png",//紅豆車輪餅
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
  List _list = List.generate(10, (index) {
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
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        title: Text("The saved food",
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
        childAspectRatio: 9/10, // 宽高比例
      ),
    );
  }
}