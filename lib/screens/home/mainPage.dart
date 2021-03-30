import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/PostEditPage.dart';
import 'package:food_bank_auth/screens/home/PostEditPage_Event.dart';
import 'package:food_bank_auth/screens/home/foodFindEventPage.dart';
import 'package:food_bank_auth/screens/home/foodFocusPage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'foodFindFoodPage.dart';


class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  var isMenuOpen = false;
  // var foodFocus = foodFocusPage();
  var pageList = [foodFocusPage(), foodFindFoodPage(),foodFindEventPage()];


  _getInit() async{
    setState(() {
      pageList = [new foodFocusPage(), new foodFindFoodPage(),new foodFindEventPage()];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build mainpadge");
    final ViewAddNewPost = Visibility(
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
    );
    final AddEvent = RawMaterialButton(
      fillColor: AddEventBtnColor,
      shape: CircleBorder(),
      padding: EdgeInsets.all(20.0),
      child: Icon(
        Icons.event,
        color: AddEventBtnIconColor,
      ),
      onPressed: () async{
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
       Navigator.push(
          context,
         MaterialPageRoute(builder: (context) => PostEditPage_Event())
        ).then((value) => _getInit());
       
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
      fillColor: Colors.orangeAccent,
      shape: CircleBorder(),
      child: Icon(
        Icons.cancel_outlined,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
    );
    final IconBtnList = Visibility(
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
    );
    final AddList = Stack(
      children: <Widget>[
        Positioned( //Visibility
          child: IconBtnList,
        ),
        Positioned( //Visibility
          child: ViewAddNewPost,
        ),
      ],
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: BGColor,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          elevation: 0.0,
          title: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  icon: Icon(
                    Icons.center_focus_strong,
                    color: Colors.white,
                  ),
              ),
              Tab(
                  icon: Icon(
                    Icons.emoji_food_beverage_rounded,
                    color: Colors.white,
                  ),
              ),
              Tab(
                  icon: Icon(
                    Icons.event_available,
                    color: Colors.white,
                  ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: pageList,
        ),
        floatingActionButton: AddList,
      ),
    );
  }
}
