import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/presetItem.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'dart:math';

import 'package:food_bank_auth/util/dataprocess.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  var tabTitle = [
    'My Food Trace',
    'My Event',
  ];

  @override
  Widget build(BuildContext context) {
    final WindowW = MediaQuery.of(context).size.width;
    final WindowH = MediaQuery.of(context).size.height;

    final AboutPine = AlertDialog(
      title: Text(
        "About Pineapple Bank",
        style: TextStyle(
          color: TitleColor,
        ),
      ),
      content: Text(
        AboutPineText,
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
          },
          child: Text(
            "I see.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final AboutUs = AlertDialog(
      title: Text(
        "About Us",
        style: TextStyle(
          color: TitleColor,
        ),
      ),
      content: Text(
        AboutUsText,
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
          },
          child: Text(
            "I see.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final ContactUs = AlertDialog(
      title: Text(
        "Contact Us",
        style: TextStyle(
          color: TitleColor,
        ),
      ),
      content: Text(
        ContactUsText,
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
          },
          child: Text(
            "I see.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final DoubleCheck = AlertDialog(
      title: Text(DoubleCheckText_t),
      content: Text(DoubleCheckText_c),
      actions: [
        FlatButton(
          textColor: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            KeepText,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          textColor: Colors.black,
          onPressed: () async {
            await _auth.signOut();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            LogOutText,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final SettingList = Wrap(
      children: [
        ListTile(
          leading: Icon(
            Icons.restaurant_menu,
            color: ListTextColor,
          ),
          title: Text(
            'About Pineapple Bank',
            style: TextStyle(
              color: ListTextColor,
            ),
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => AboutPine);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.tag_faces,
            color: ListTextColor,
          ),
          title: Text(
            'About Us',
            style: TextStyle(
              color: ListTextColor,
            ),
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => AboutUs);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.support_agent,
            color: ListTextColor,
          ),
          title: Text(
            'Contact Us',
            style: TextStyle(
              color: ListTextColor,
            ),
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => ContactUs);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.login_outlined,
            color: LogOutColor,
          ),
          title: Text(
            LogOutText,
            style: TextStyle(
              color: LogOutColor,
            ),
          ),
          onTap: () {
            showDialog<void>(
                context: context, builder: (context) => DoubleCheck);
          },
        ),
      ],
    );

    final PineRadius = WindowW / 10;
    final pinePhoto = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: PineRadius,
          height: PineRadius,
          decoration: BoxDecoration(
            color: LocationColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: PineRadius - 4,
          height: PineRadius - 4,
          decoration: BoxDecoration(
            color: ArticleColor,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: PineRadius - 10,
          height: PineRadius - 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/ic_launcher_smile.png'),
            ),
          ),
        ),
      ],
    );
    final ABleading = Row(
      children: <Widget>[
        SizedBox(width: Width_Size_S),
        pinePhoto,
      ],
    );
    final UserName = Text(
      "Ms.Prune ",
      style: TextStyle(
        color: Colors.white,
      ),
    );
    final AppBarBtn = Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: LocationColor,
            size: ABIconSize,
          ),
          onPressed: () {
            showModalBottomSheet<void>(
                context: context, builder: (context) => SettingList);
          },
        ),
        SizedBox(width: Width_Size_S),
      ],
    );

    final UserRadius = MediaQuery.of(context).size.width / 4;
    final UserPhoto = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: UserRadius + 10,
          height: UserRadius + 10,
          decoration: BoxDecoration(
            color: Color(0xFFffff99),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: UserRadius,
          height: UserRadius,
          decoration: BoxDecoration(
            color: Color(0xFFffcc00),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: UserRadius - 10,
          height: UserRadius - 10,
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

    final HadConsidered = FlatButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => presetConedPage()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: UserRadius * 4 / 5,
            height: UserRadius * 5 / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BtnPineapple.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            // Replace with a Row for horizontal icon + text
            children: <Widget>[
              Icon(
                Icons.bookmark,
                color: SavedBtnIconColor,
              ),
              Text(
                "Marked",
                style: TextStyle(
                  color: SavedBtnIconColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    final HadSaved = FlatButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => presetSavedPage()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: UserRadius * 4 / 5,
            height: UserRadius * 5 / 5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BtnPineapple.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            // Replace with a Row for horizontal icon + text
            children: <Widget>[
              Icon(
                Icons.bookmark,
                color: SavedBtnIconColor,
              ),
              Text(
                "Saved",
                style: TextStyle(
                  color: SavedBtnIconColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final PointText = Container(
      width: WindowW * 4 / 10,
      height: 40.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xAACCFF80), Color(0xAAFFFF93), Color(0xAAFFE66F),
            // Color(0xAAFFC78E), Color(0xAAFFAD86), Color(0xAAFF7575),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(width: 5, color: PointBlockLine),
      ),
      child: Center(
        child: FlatButton(
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "TIPS",
                        style: TextStyle(
                          color: ArticleColor,
                        ),
                      ),
                      content: RichText(
                        text: TextSpan(
                          style: TextStyle(color: ArticleColor),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "Saving food or posting food can let you get point."),
                            TextSpan(text: "\n(10 point = 1 Reliability)"),
                            TextSpan(
                                text:
                                    "\n\nGetting 100 Reliability and then you can become a "),
                            TextSpan(
                                text: "Volunteer",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " !!\n"),
                            TextSpan(
                                text: "Volunteer",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    " can collect nearby food and hold event."),
                          ],
                        ),
                      ),
                      actions: [
                        FlatButton(
                          //Cancel
                          textColor: Colors.orange,
                          onPressed: () {
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
                    ));
          },
          child: Text(
            "Reliability",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    final H = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Spacer(),
        Spacer(),
        Container(
          width: WindowW * 1 / 20,
          height: 8.0,
          decoration: BoxDecoration(
            color: PointBlockLine,
          ),
        ),
        Spacer(),
        Container(
          width: WindowW * 1 / 20,
          height: 8.0,
          decoration: BoxDecoration(
            color: PointBlockLine,
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
    final UserPoint = Container(
      width: WindowW * 9 / 10,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(width: 5, color: PointBlockLine),
      ),
      child: Container(
        width: WindowW * 8 / 10,
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCCFF80), Color(0xFFFFFF93), Color(0xFFFFE66F),
              // Color(0xFFFFC78E), Color(0xFFFFAD86), Color(0xFFFF7575),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Center(
          child: FlatButton(
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          "TIPS",
                          style: TextStyle(
                            color: ArticleColor,
                          ),
                        ),
                        content: RichText(
                          text: TextSpan(
                            style: TextStyle(color: ArticleColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "Saving food or posting food can let you get point."),
                              TextSpan(text: "\n(10 point = 1 Reliability)"),
                              TextSpan(
                                  text:
                                      "\n\nGetting 100 Reliability and then you can become a "),
                              TextSpan(
                                  text: "Volunteer",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " !!\n"),
                              TextSpan(
                                  text: "Volunteer",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      " can collect nearby food and hold event."),
                            ],
                          ),
                        ),
                        actions: [
                          FlatButton(
                            //Cancel
                            textColor: Colors.orange,
                            onPressed: () {
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
                      ));
            },
            child: Text(
              " 1 0 0 / 1 0 0 ",
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    final BadgeText = Container(
      width: WindowW * 4 / 10,
      height: 40.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xAACCFF80), Color(0xAAFFFF93), Color(0xAAFFE66F),
            Color(0xAAFFC78E), Color(0xAAFFAD86), Color(0xAAFF7575),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(width: 5, color: BadgeBlockLine),
      ),
      child: Center(
        child: Text(
          "Badge",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    final firstSign = FlatButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Newbie Pineapple Badge",
                    style: TextStyle(
                      color: ArticleColor,
                    ),
                  ),
                  content: Text(
                    "first sign up : 2021/01/28",
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
                      },
                      child: Text(
                        "I see.",
                        style: TextStyle(
                          fontSize: wordsSize_S,
                        ),
                      ),
                    ),
                  ],
                ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: BadgeSize,
            height: BadgeSize,
            decoration: BoxDecoration(
              color: BadgeBGcolor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: BadgeImgSize,
            height: BadgeImgSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/B_firstsignup.png'),
              ),
            ),
          ),
        ],
      ),
    );
    final firstSave = FlatButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "PinePinePineapple Badge",
                    style: TextStyle(
                      color: ArticleColor,
                    ),
                  ),
                  content: Text(
                    "first save food : 2021/01/31",
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
                      },
                      child: Text(
                        "I see.",
                        style: TextStyle(
                          fontSize: wordsSize_S,
                        ),
                      ),
                    ),
                  ],
                ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: BadgeSize,
            height: BadgeSize,
            decoration: BoxDecoration(
              color: BadgeBGcolor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: BadgeImgSize,
            height: BadgeImgSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/B_firstsave.png'),
              ),
            ),
          ),
        ],
      ),
    );
    final firstPost = FlatButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Green Pineapple Badge",
                    style: TextStyle(
                      color: ArticleColor,
                    ),
                  ),
                  content: Text(
                    "first post food : 2021/01/31",
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
                      },
                      child: Text(
                        "I see.",
                        style: TextStyle(
                          fontSize: wordsSize_S,
                        ),
                      ),
                    ),
                  ],
                ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: BadgeSize,
            height: BadgeSize,
            decoration: BoxDecoration(
              color: BadgeBGcolor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: BadgeImgSize,
            height: BadgeImgSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/B_firstpost.png'),
              ),
            ),
          ),
        ],
      ),
    );
    final firstEvent = FlatButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Partyapple Badge",
                    style: TextStyle(
                      color: ArticleColor,
                    ),
                  ),
                  content: Text(
                    "first hold event : 2021/02/21",
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
                      },
                      child: Text(
                        "I see.",
                        style: TextStyle(
                          fontSize: wordsSize_S,
                        ),
                      ),
                    ),
                  ],
                ));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: BadgeSize,
            height: BadgeSize,
            decoration: BoxDecoration(
              color: BadgeBGcolor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: BadgeImgSize,
            height: BadgeImgSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/B_firstevent.png'),
              ),
            ),
          ),
        ],
      ),
    );
    final UserBadge = Container(
      width: WindowW * 9 / 10,
      height: 100.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xAACCFF80), Color(0xAAFFFF93), Color(0xAAFFE66F),
            Color(0xAAFFC78E), Color(0xAAFFAD86), Color(0xAAFF7575),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(width: 5, color: BadgeBlockLine),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Spacer(),
          firstSign,
          firstSave,
          firstPost,
          firstEvent,
          Spacer(),
        ],
      ),
    );

    final UserInfo = Column(
      children: <Widget>[
        SizedBox(height: Height_Size_L * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(),
            Spacer(),
            UserPhoto,
            Spacer(),
            Spacer(),
            HadConsidered,
            HadSaved,
            Spacer(),
          ],
        ),
        SizedBox(height: Height_Size_L / 2),
        PointText,
        H,
        UserPoint,
        SizedBox(height: Height_Size_L / 2),
        BadgeText,
        H,
        UserBadge,
      ],
    );

    return DefaultTabController(
        length: tabTitle.length,
        child: Scaffold(
          backgroundColor: BGColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                SliverAppBar(
                  // backgroundColor: BGColor,
                  elevation: 0.0,
                  expandedHeight: WindowH * 4 / 7,
                  floating: true,
                  pinned: true,
                  leading: ABleading,
                  title: UserName,
                  actions: [
                    AppBarBtn,
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserInfo,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  // floating: true,
                  delegate: SliverTabBarDelegate(
                    TabBar(
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      indicatorColor: Color(0xFFffbb77),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Color(0xFFffbb77),
                    ),
                    color: Colors.white,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                foodTracePage(),
                eventTracePage(),
              ],
            ),
          ),
        ));
  }
}

//實作滑動Head
class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}

//foodTracePage
class foodTItem extends StatefulWidget {
  foodTItem(
      {this.location,
      this.intro,
      this.year,
      this.month,
      this.day,
      this.title,
      this.photoUrl});

  final String location;
  final String intro;
  final String year;
  final String month;
  final String day;
  final String photoUrl;
  final String title;

  @override
  _foodTItemState createState() => _foodTItemState();
}

class _foodTItemState extends State<foodTItem> {
  final foodPhoto = "images/presetP1.png";
  final foodName = "pineapple tidbit(500g)";

  @override
  Widget build(BuildContext context) {
    final SucceedPost = AlertDialog(
      content: Text(
        "You are successful to post the food!"
        "\nPlease wait someone to save it."
        "\n\nIf the food is saved by someone, you can get 5 point.",
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
          },
          child: Text(
            "I see.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final PostMyFood = AlertDialog(
      title: Text("TIPS"),
      content: Text(
          "${widget.title} is nearly expired! \n Are you sure to post your food?"),
      actions: [
        FlatButton(
          textColor: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Cancel
          textColor: Colors.orange,
          onPressed: () {
            showDialog<void>(
                context: context, builder: (context) => SucceedPost);
          },
          child: Text(
            "Yes, I want to post.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final SucceedFinish = AlertDialog(
      content: Text(
        "Great( ･ิ ◡･ิ)!"
        "\nAdvocate festival food culture, and promote the sustainable development.",
        style: TextStyle(
          color: ArticleColor,
        ),
      ),
      actions: [
        FlatButton(
          textColor: Colors.orange,
          onPressed: () {
            Navigator.pop(context);
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
    );
    final FinishFood = AlertDialog(
      title: Text("TIPS"),
      content: Text("Are you sure your food has been finished?"),
      actions: [
        FlatButton(
          textColor: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Cancel
          textColor: Colors.orange,
          onPressed: () {
            showDialog<void>(
                context: context, builder: (context) => SucceedFinish);
          },
          child: Text(
            "Yes, I want to post.",
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), //加上一層透明0.5的黑
                BlendMode.dstATop //混合模式，放到上面去
                ),
            image: NetworkImage(widget.photoUrl),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              // leading: Icon(Icons.person,color: Colors.grey,),
              title: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in ${widget.location}'
                '\nDate:${widget.year}/${widget.month}/${widget.day}'
                '\n${widget.intro.length > 8 ? widget.intro.substring(0, 9) : widget.intro}...',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFFb87333), fontWeight: FontWeight.w600),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: () {
                    showDialog<void>(
                        context: context, builder: (context) => PostMyFood);
                  },
                  child: Text(
                    'Post',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
                FlatButton(
                  // textColor: Color(0xFF6200EE),
                  onPressed: () {
                    showDialog<void>(
                        context: context, builder: (context) => FinishFood);
                  },
                  child: Text(
                    'Finished',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.brown),
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

class foodTracePage extends StatelessWidget {
  List _list = List.generate(16, (index) {
    return index;
  });

  List<Widget> _getGridList() {
    return _list.map((item) {
      return foodTItem();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BGColor,
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 9 / 10),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  var location = snapshot.data[index].city;
                  var title = snapshot.data[index].name;
                  var photoUrl = snapshot.data[index].photo;
                  var datetime = DateTime.fromMicrosecondsSinceEpoch(snapshot
                      .data[index].best_before_time.microsecondsSinceEpoch);
                  var year = datetime.year;
                  var month = datetime.month;
                  var day = datetime.day;
                  var intro = snapshot.data[index].introduction;
                  return foodTItem(
                      location: location,
                      intro: intro,
                      year: year.toString(),
                      month: month.toString(),
                      day: day.toString(),
                      title: title,
                      photoUrl: photoUrl);
                },
                //crossAxisSpacing: 10, // 水平距离
                //mainAxisSpacing: 10, // 垂直距离
                //childAspectRatio: 9/10, // 宽高比例
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Future<List<dynamic>> getData() async {
  print("getFoodData Profilepage");
  var foodPost;
  DataFetch s = DataFetch();
  foodPost = await s.fetchPostdata();
  print(foodPost);
  return foodPost;
}

//eventTracePage
class eventItem extends StatelessWidget {
  int dateDay = Random().nextInt(5) + 20;
  final eventPhoto = "images/presetE1.png";
  final eventName = "Pick fresh apples!";

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
            image: AssetImage(eventPhoto),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                eventName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF8b4513)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'in Taichung......\n'
                '\nDate:2021/02/${dateDay}'
                '\nTime : 13:30-17:00\n\n'
                'Evaluation : ★★★★☆',
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

class eventTracePage extends StatelessWidget {
  List _list = List.generate(5, (index) {
    return index;
  });

  List<Widget> _getGridList() {
    return _list.map((item) {
      return eventItem();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BGColor,
        body: GridView.count(
          children: _getGridList(),
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          // 水平距离
          mainAxisSpacing: 10,
          // 垂直距离
          childAspectRatio: 9 / 10, // 宽高比例
        ));
  }
}
