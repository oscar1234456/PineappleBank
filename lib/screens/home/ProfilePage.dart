import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/chatRoom/chatWindow.dart';
import 'package:food_bank_auth/screens/home/Profile_TabPage.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/presetItem.dart';
import 'package:food_bank_auth/util/styleDesign.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final _userPoint = 100;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _userName ;
  String _userPhoto ;
  var tabTitle = [
    'My Food Trace',
    'My Event',
  ];

  @override
  void initState() {
    super.initState();
    _userName = _auth.currentUser.displayName;
    _userPhoto = _auth.currentUser.photoURL ;
  }

  @override
  Widget build(BuildContext context) {
    //部件尺寸依螢幕寬度調整
    final WindowW = MediaQuery.of(context).size.width;
    final WindowH = MediaQuery.of(context).size.height;
    final AppBarFiexHeight = WindowH * 4 / 7;
    final UserRadius = WindowW / 4;
    final PineBtnDesign_size = UserRadius * 4 / 5;
    final PineRadius = WindowW / 10;
    final TextBlockW = WindowW * 4 / 10;
    final TextBlockH = 40.0;
    final ContentBlockW = WindowW * 9 / 10;
    final ContentBlockH = 50.0;
    final ContentBlockW2 = WindowW * 8 / 10;
    final ContentBlockH2 = 100.0;

    //常用返回建(跳出AlertDialog)
    final BackBtn = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        OKoptionText,
        style: DiaOptStyle,
      ),
    );
    final BackBackBtn = TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Text(
        OKoptionText,
        style: DiaOptStyle,
      ),
    );

    //AppBar_右上角SettingList
    final AboutPine = AlertDialog(
      title: Text(
        AboutPine_title,
        style: DiaTitleStyle,
      ),
      content: Text(
        AboutPineText,
        style: DiaConStyle,
      ),
      actions: [
        BackBackBtn,
      ],
    );
    final AboutUs = AlertDialog(
      title: Text(
        AboutUs_title,
        style: DiaTitleStyle,
      ),
      content: Text(
        AboutUsText,
        style: DiaConStyle,
      ),
      actions: [
        BackBackBtn,
      ],
    );
    final ContactUs = AlertDialog(
      title: Text(
        ContactUs_title,
        style: DiaTitleStyle,
      ),
      content: Text(ContactUsText,
        style: DiaConStyle,
      ),
      actions: [
        BackBackBtn,
      ],
    );
    final DoubleCheck = AlertDialog(
      title: Text(
        DoubleCheck_title,
        style: DiaTitleStyle,
      ),
      content: Text(
        DoubleCheckText,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            "Keep Log in.",
            style: DiaOptStyle,
          ),
        ),
        TextButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            LogOutText,
            style: LogOutTextStyle,
          ),
        ),
      ],
    );
    final SettingList = Wrap(
      children: [
        ListTile(
          leading: AboutPine_icon,
          title: Text(
            AboutPine_title,
            style: ListTextStyle,
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => AboutPine);
          },
        ),
        ListTile(
          leading: AboutUs_icon,
          title: Text(
            AboutUs_title,
            style: ListTextStyle,
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => AboutUs);
          },
        ),
        ListTile(
          leading: ContactUs_icon,
          title: Text(
            ContactUs_title,
            style: ListTextStyle,
          ),
          onTap: () {
            showDialog<void>(context: context, builder: (context) => ContactUs);
          },
        ),
        ListTile(
          leading: LogOut_icon,
          title: Text(
            LogOutText,
            style: LogOutTextStyle,
          ),
          onTap: () {
            showDialog<void>(
                context: context, builder: (context) => DoubleCheck);
          },
        ),
      ],
    );

    //AppBar_左上角AppIcon
    final ABleading = Row(
      children: <Widget>[
        SizedBox(width: Width_Size_S),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: PineRadius,
              height: PineRadius,
              decoration: IconBGDesign[0],
            ),
            Container(
              width: PineRadius - 4,
              height: PineRadius - 4,
              decoration: IconBGDesign[1],
            ),
            Container(
              //鳳梨本體AppIcon
              width: PineRadius - 10,
              height: PineRadius - 10,
              decoration: IconBGDesign[2],
            ),
          ],
        ),
      ],
    );

    //AppBar_用戶姓名
    final UserName = Text(
      _userName,
      style: UserNameDesign,
    );
    final AppBarBtn = Row(
      children: <Widget>[
        IconButton(
          icon: ChatWindowBtnIcon ,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatWindow()));
          },
        ),
        IconButton(
          icon: AppSettingBtnIcon,
          onPressed: () {
            showModalBottomSheet<void>(
                context: context, builder: (context) => SettingList);
          },
        ),
        SizedBox(width: Width_Size_S),
      ],
    );

    //AppBar伸縮區(flexibleSpace)
    //AppBar_用戶照片
    //final UserRadius = MediaQuery.of(context).size.width / 4;
    final UserPhoto = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: UserRadius + 10,
          height: UserRadius + 10,
          decoration: UserPhotoDesign[0],
        ),
        Container(
          width: UserRadius,
          height: UserRadius,
          decoration: UserPhotoDesign[1],
        ),
        Container(
          width: UserRadius - 10,
          height: UserRadius - 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              // image: AssetImage(UserAImgPath),//For test
              image: NetworkImage(_userPhoto),
            ),
          ),
        ),
      ],
    );
    //AppBar_歷史紀錄(考慮中/拯救過)
    final HadMarked = TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => presetConedPage()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: PineBtnDesign_size,
            height: PineBtnDesign_size * 5 / 4,
            decoration: PineappleBtnDesign,
          ),
          Column(
            //icon + text
            children: <Widget>[
              PBtnHistory_icon,
              PBtnHistory_text,
            ],
          ),
        ],
      ),
    );
    final HadSaved = TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => presetSavedPage()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: PineBtnDesign_size,
            height: PineBtnDesign_size * 5 / 4,
            decoration: PineappleBtnDesign,
          ),
          Column(
            // Replace with a Row for horizontal icon + text
            children: <Widget>[
              PBtnSaved_icon,
              PBtnSaved_text,
            ],
          ),
        ],
      ),
    );
    //AppBar_經驗值
    final ExpDescription = AlertDialog(
      title: Text(
        BlockDescription_title,
        style: DiaTitleStyle,
      ),
      content: BlockDescription_Exp,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            OKoptionText,
            style: DiaOptStyle,
          ),
        ),
      ],
    );
    final ExpTitleBlock = Container(
      width: TextBlockW,
      height: TextBlockH,
      decoration: ExpTextBlockDesign,
      child: Center(
        child: TextButton(
          onPressed: () {
            showDialog<void>(
                context: context, builder: (context) => ExpDescription);
          },
          child: Text(
            ExpTitle,
            style: BlockTitleStyle,
          ),
        ),
      ),
    );
    final UserPoint = Container(
      width: ContentBlockW,
      height: ContentBlockH,
      decoration: ExpBlockDesign[0],
      child: Container(
        width: ContentBlockW2,
        height: TextBlockH,
        decoration: ExpBlockDesign[1],
        child: Center(
          child: TextButton(
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          BlockDescription_title,
                          style: DiaTitleStyle,
                        ),
                        content: BlockDescription_Exp,
                        actions: [
                          BackBtn,
                        ],
                      ));
            },
            child: Text(
              " ${_userPoint} / 100 ",
              style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    //AppBar_徽章
    final BadgeText = Container(
      width: TextBlockW,
      height: TextBlockH,
      decoration: BadgeTextBlockDesign,
      child: Center(
        child: Text(
          BadgeTitle,
          style: BlockTitleStyle,
        ),
      ),
    );
    final firstSign = TextButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    BadgeName[0],
                    style: DiaTitleStyle,
                  ),
                  content: Text(
                    BadgeName[1],
                    style: DiaConStyle,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        OKoptionText,
                        style: DiaOptStyle,
                      ),
                    ),
                  ],
                ));
      },
      child: firstSignBadge,
    );
    final firstSave = TextButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    BadgeName[2],
                    style: DiaTitleStyle,
                  ),
                  content: Text(
                    BadgeName[3],
                    style: DiaConStyle,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        OKoptionText,
                        style: DiaOptStyle,
                      ),
                    ),
                  ],
                ));
      },
      child: firstSaveBadge,
    );
    final firstPost = TextButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    BadgeName[4],
                    style: DiaTitleStyle,
                  ),
                  content: Text(
                    BadgeName[5],
                    style: DiaConStyle,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        OKoptionText,
                        style: DiaOptStyle,
                      ),
                    ),
                  ],
                ));
      },
      child: firstPostBadge,
    );
    final firstEvent = TextButton(
      onPressed: () {
        showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    BadgeName[6],
                    style: DiaTitleStyle,
                  ),
                  content: Text(
                    BadgeName[7],
                    style: DiaConStyle,
                  ),
                  actions: [
                    BackBtn,
                  ],
                ));
      },
      child: firstEventBadge,
    );
    final UserBadge = Container(
      width: ContentBlockW,
      height: ContentBlockH2,
      decoration: BadgeBlockDesign,
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
    //AppBar_flexibleSpace
    final UserInfo = Column(
      children: <Widget>[
        SizedBox(height: Height_Size_L * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(flex: 2,),
            UserPhoto,
            Spacer(flex: 2,),
            HadMarked,
            HadSaved,
            Spacer(),
          ],
        ),
        SizedBox(height: Height_Size_L/2),
        ExpTitleBlock,
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
          body: NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                SliverAppBar(
                  elevation: 0.0,//無陰影
                  expandedHeight: AppBarFiexHeight,
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
                  delegate: SliverTabBarDelegate(
                    TabBar(
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      indicatorColor: TabBarTextColor[1],
                      unselectedLabelColor: TabBarTextColor[0],
                      labelColor: TabBarTextColor[1],
                    ),
                    color: PineappleWhite,
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
        )
    );
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