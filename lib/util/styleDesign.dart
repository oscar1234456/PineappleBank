import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/styleDesignImg.dart';
import 'package:food_bank_auth/util/constants.dart';

//常用全域設計 //主題色彩在最下面喔OuO

//首頁食物顏色等級
class FoodColor{
  static const Color foodColor_level1 = Color(0xFFff8a80); //most emergency
  static const Color foodColor_level2 = Color(0xFFffe57f);
  static const Color foodColor_level3 = Color(0xFFc5e1a5);
}
//AlertDialog
const Color TitleColor = Color(0xFF8b4513);
const Color ArticleColor = Color(0xFFb87333);
const Color OptionColor = Colors.orange;
const DiaTitleStyle = TextStyle(
  fontSize: TitleWordsSize,
  color: TitleColor,
);
const DiaConStyle = TextStyle(
  fontSize: NormalWordsSize,
  color: ArticleColor,
);
const DiaOptStyle = TextStyle(
  fontSize: NormalWordsSize,
  color: OptionColor,
);//I see.
const DiaOptDesign = [//Yes or No
  TextStyle(
    color: Colors.grey,
    fontSize: NormalWordsSize,
  ),
  TextStyle(
    color: Colors.orange,
    fontSize: NormalWordsSize,
  ),
];
//TextFormField
const Color InputColor = Color(0xFFbc8f8f);//focused游標、文字、邊框、show文字
const Color InputCursorColor = Colors.brown;
const InputBlockDesign = [
  TextStyle(
    color: InputColor,
  ),
  TextStyle(
    color: InputCursorColor,
    fontSize: NormalWordsSize,
  ),
];
//Icon
const TagIcon = Icon(
  Icons.tag,
  color: Colors.white70,
);
const BackIcon = Icon(
  Icons.west_outlined,
  color: Colors.deepOrange,
  size: ABIconSize,
);
const DoneIcon = Icon(
  Icons.check,
  color: Colors.white,
  size: ABIconSize,
);
//Text
const WhiteTextDesign = TextStyle(
  color: Colors.white,
);


//ChatRoom
const MsgInputBlockDesign = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.grey, width: 0.5,),
  ),
  color: Colors.white,
);
const MsgInputBlockBoard = UnderlineInputBorder(
  borderSide: BorderSide(
    color: InputCursorColor,
    width: TextFocusedLine,
  ),
);
final MsgInputBlockIcon = [
  Icon(//Add Image
    Icons.image,
    size: 30.0,
    color: Colors.brown[300],
  ),
  Icon(//Add Sticker
    Icons.face,
    size: 30.0,
    color: Colors.brown[300],
  ),
  Icon(//Send Msg
    Icons.send,
    size: 30.0,
    color: Pineapple900,
  ),
];
final myMsgBoxDesign = BoxDecoration(
  color: Colors.brown[400],
  borderRadius: BorderRadius.circular(10.0),
);
const myMsgTextDesign = TextStyle(color: Colors.white);
const myMsgBoxMargin = EdgeInsets.only(bottom: 10.0, right: 10.0);
final MsgBoxDesign = BoxDecoration(
  color: Colors.orange,
  borderRadius: BorderRadius.circular(10.0),
);
const MsgTextDesign = TextStyle(color: Colors.white);
const MsgBoxPadding = EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0);
//ChatWindow
const chatBoxTextStyle = TextStyle(color: Colors.white70);
const chatBoxTextStyleUser = TextStyle(color: Colors.white70,fontSize: 25,);
final chatBoxDesign = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown[300]),
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0)),
);
final chatBoxAppIconDesign = [
  BoxDecoration(
    color: Pineapple50,
    shape: BoxShape.circle,
  ),
  BoxDecoration(
    color: Pineapple300,
    shape: BoxShape.circle,
  ),
  BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(AppIconImgPath[1]),
    ),
  ),
];
final chatBoxIcon = Icon(
  Icons.account_circle,
  size: 50.0,
  color: Colors.grey,
);



//FoodTrace(Profile_TabPage)
const List<Color> TabBarTextColor = [
  Colors.grey,
  Color(0xFFffbb77),
];
const FoodTraceOptionDesign = [
  TextStyle(color: Colors.orangeAccent),//Post
  TextStyle(color: Colors.brown),//Finish
];
const MyFoodNameStyle = TextStyle(
  color: Color(0xFF8b4513),
  fontWeight: FontWeight.bold,
);
const MyFoodTextStyle = TextStyle(
  color: Color(0xFFb87333),
);
//EventNote(Profile_TabPage)
const EventNoteTextDesign = [
  TextStyle(
    color: Color(0xFF8b4513),
    fontWeight: FontWeight.bold,
  ),
  TextStyle(color: Color(0xFFb87333)),
];
//foodArticlePage
const Color SaveBtnColor  = Colors.amber;
const Color SaveBtnIconColor = Colors.red;
final SaveBtnDesign = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RaisedButtonborderRadius),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(SaveBtnColor),
);
const Color LocationColor = Color(0xFFcc5000);
//eventArticlePage
const partiBtnIcon = [
  Icon(
    Icons.grade_outlined,
    color: SaveBtnIconColor,
  ),
  Icon(
    Icons.grade,
    color: SaveBtnIconColor,
  ),
];

//
//mainPage
//
const Color AddEventBtnColor = Color(0xDDFFAD86);//Color(0xFFFFDE9D);
const Color AddEventBtnIconColor = Colors.deepOrangeAccent;
//mainPage_AddList
const CloseBtnList_Icon = Icon(
  Icons.cancel_outlined,
  color: Colors.white,
);
const AddEvent_Icon = Icon(
  Icons.event,
  color: AddEventBtnIconColor,
);
//
//PostEditPage
//
//PostEditPage_HashTag
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
    with AutomaticKeepAliveClientMixin<Content>  {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      color: Colors.orangeAccent[100],
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
//PostEditPage_Photo
final pinePhoto = Container(
  width: 30,
  height: 30,
  child: Image(
    image: AssetImage('images/ic_launcher_smile.png'),
  ),
);
final presetNoPhoto = Container(
  child: Image(
    image: AssetImage(noPhotoImgPath),
  ),
);
final XIcon = Icon(
  Icons.cancel,
  color: AddEventBtnIconColor,
);
final ArticleTitleBlockDesign = InputDecoration(
  icon: Icon(
    Icons.fastfood,
    color: Colors.white70,
  ),
  labelText: TitleLabelText,
  hintText: TitleHintText,
  labelStyle: TextStyle(
      color: FocusNode().hasFocus ? InputCursorColor : InputColor
  ),
  filled: true,
  fillColor: ShowBlockColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(
      color: InputColor,
      width: TextFocusedLine,
    ),
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
);
final ArticleTextBlockDesign = InputDecoration(
  icon: Icon(
    Icons.article,
    color: Colors.white70,
  ),
  labelText: ArticleLabelText,
  hintText: ArticleHelperText,
  labelStyle: TextStyle(
      color: FocusNode().hasFocus ? InputCursorColor : InputColor
  ),
  filled: true,
  fillColor:ShowBlockColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(
      color: InputColor,
      width: TextFocusedLine,
    ),
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
);
const Color ButtonIconColor = Colors.white; //with ButtonText
const Color ButtonBGColor_Photo = Color(0xFFffbb77);
const Color ButtonBGColor_Date = Color(0xFFffa042);
const Color ButtonBGColor_Location = Color(0xFFff9000);
final DateBtnDesign = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RaisedButtonborderRadius),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(ButtonBGColor_Date),
);
final DateBtnText = Text(
  ExpirationDateText,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(color: ButtonIconColor,),
);
final DateBtnIcon = Icon(
  Icons.date_range_outlined,
  color: ButtonIconColor,
);
final LocationBtnDesign = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RaisedButtonborderRadius),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(ButtonBGColor_Location),
);
final LocationBtnText = Text(
  LocationText,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(color: ButtonIconColor),
);
final LocationBtnIcon = Icon(
  Icons.location_on_outlined,
  color: ButtonIconColor,
);
const Color ShowBlockColor = Colors.white54; //showDate、showLocation
final PhotoBtnDesign = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(RaisedButtonborderRadius),
    ),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(ButtonBGColor_Photo),
);
final PhotoCameraBtnText = Text(
  "Camera",
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    color: ButtonIconColor,
  ),
);
final PhotoCameraBtnIcon = Icon(
  Icons.photo_camera,
  color: ButtonIconColor,
);
final PhotoLibraryBtnText = Text(
  "Library",
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    color: ButtonIconColor,
  ),
);
final PhotoLibraryBtnIcon = Icon(
  Icons.photo_library,
  color: ButtonIconColor,
);
final doubleCheckText = [
  Text(
    doubleCheck_X,
    style: DiaOptDesign[0],
  ),
  Text(
    doubleCheck_O,
    style: DiaOptDesign[1],
  ),
];
//PostEditPage_Event
final EventDateBtnText = Text(
  EventDateText,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(color: ButtonIconColor,),
);
final EventTimeEBtnText = Text(Event_TimeEnd,
  style: TextStyle(color: ButtonIconColor),
);
final EventTimeEBtnIcon = Icon(
  Icons.access_time_sharp,
  color: ButtonIconColor,
);
final EventTimeSBtnText = Text(Event_TimeStart,
  style: TextStyle(color: ButtonIconColor),
);
final EventTimeSBtnIcon = Icon(
  Icons.more_time_outlined,
  color: ButtonIconColor,
);
//
//ProfilePage
//
//ProfilePage_AppIconDesign
const Color IconCircleColor = Color(0xFFcc5000);
const Color IconCircleBGColor = Color(0xFFb87333);
final IconBGDesign = [
  BoxDecoration(
    color: IconCircleColor,
    shape: BoxShape.circle,
  ),
  BoxDecoration(
    color: IconCircleBGColor,
    shape: BoxShape.circle,
  ),
  BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(AppIconImgPath[1]),
    ),
  ),
];
//ProfilePage_UserName
const UserNameDesign = TextStyle(
  color: Colors.white,
);
//ProfilePage_SettingBtn
const AppSettingBtnIcon = Icon(
  Icons.settings,
  color: LocationColor,
  size: ABIconSize,
);
//ProfilePage_ChatBtn
const ChatWindowBtnIcon = Icon(
  Icons.message,
  color: LocationColor,
  size: ABIconSize,
);
//ProfilePage_UserPhoto
const UserPhotoDesign = [
  BoxDecoration(
    color: Color(0xFFffff99),
    shape: BoxShape.circle,
  ),
  BoxDecoration(
    color: Color(0xFFffcc00),
    shape: BoxShape.circle,
  ),
];
//ProfilePage_BtnDesign
const Color PBtnColor = Color(0xFF804040);
const PineappleBtnDesign = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(PineappleBtnImgPath),
    fit: BoxFit.fitWidth,
    alignment: Alignment.topCenter,
  ),
);
const PBtnHistory_icon = Icon(
  Icons.history_toggle_off_rounded,
  color: PBtnColor,
);
const PBtnHistory_text = Text(
  "History",
  style: TextStyle(
    color: PBtnColor,
  ),
);
const PBtnSaved_icon = Icon(
  Icons.bookmark,
  color: PBtnColor,
);
const PBtnSaved_text = Text(
  "Saved",
  style: TextStyle(
    color: PBtnColor,
  ),
);
//ProfilePage_Block
const Color PointBlockLineColor = Color(0xAAFFFFCC);
final ExpTextBlockDesign = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xAACCFF80),
      Color(0xAAFFFF93),
      Color(0xAAFFE66F),
    ],
  ),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  border: Border.all(
    width: 5,
    color: PointBlockLineColor,
  ),
);
final BadgeTextBlockDesign = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xAAFFC78E),
      Color(0xAAFFAD86),
      Color(0xAAFF7575),
    ],
  ),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  border: Border.all(width: 5, color: PointBlockLineColor),
);
final ExpBlockDesign = [
  BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    border: Border.all(width: 5, color: PointBlockLineColor),
  ),
  BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFCCFF80),
        Color(0xFFFFFF93),
        Color(0xFFFFE66F),
      ],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  )
];
final BadgeBlockDesign = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xAAFFC78E),
      Color(0xAAFFAD86),
      Color(0xAAFF7575),
    ],
  ),
  borderRadius: BorderRadius.all(Radius.circular(25.0)),
  border: Border.all(width: 5, color: PointBlockLineColor),
);
const BlockTitleStyle = TextStyle(
  color: Colors.white,
);
const H_width = 20.0; const H_height = 8.0;
final H = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Spacer(flex: 2,),
    Container(
      width: H_width,
      height: H_height,
      decoration: BoxDecoration(
        color: PointBlockLineColor,
      ),
    ),
    Spacer(),
    Container(
      width: H_width,
      height: H_height,
      decoration: BoxDecoration(
        color: PointBlockLineColor,
      ),
    ),
    Spacer(flex: 2,),
  ],
);
//ProfilePage_Badge
const Color BadgeBGcolor = Colors.white24;
final firstSignBadge = Stack(
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
          image: AssetImage(BadgeImgPath[0]),
        ),
      ),
    ),
  ],
);
final firstSaveBadge = Stack(
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
          image: AssetImage(BadgeImgPath[2]),
        ),
      ),
    ),
  ],
);
final firstPostBadge = Stack(
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
          image: AssetImage(BadgeImgPath[4]),
        ),
      ),
    ),
  ],
);
final firstEventBadge = Stack(
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
          image: AssetImage(BadgeImgPath[6]),
        ),
      ),
    ),
  ],
);
//ProfilePage_SettingList(Sheets/Wrap)
const Color ListTextColor = Color(0xFFcd853f);
const ListTextStyle = TextStyle(
  color: ListTextColor,
);
const AboutPine_icon = Icon(
  Icons.restaurant_menu,
  color: ListTextColor,
);
const AboutUs_icon = Icon(
  Icons.tag_faces,
  color: ListTextColor,
);
const ContactUs_icon = Icon(
  Icons.support_agent,
  color: ListTextColor,
);
//ProfilePage_LogOut
const Color LogOutColor = Color(0xFF8b4513);
const LogOut_icon = Icon(
  Icons.login_outlined,
  color: LogOutColor,
);
const LogOutTextStyle = TextStyle(
  color: LogOutColor,
  fontSize: NormalWordsSize,
  fontWeight: FontWeight.bold,
);
//SignInPage/RegisterPage
const Color SignInBGcolor = Color(0xFFffdead);
const Color SignInBarColor = Color(0xFFbc8f8f);
const AppBarAppName = Text(
  AppNameText,
  style: TextStyle(
    color: Colors.white,
  ),
);
const divLineDesign = DecoratedBox(
  decoration: BoxDecoration(
    color: Color(0xFFbc8f8f),
  ),
);
final EmailInputDesign = InputDecoration(
  labelText: pinEmailText,
  hintText: pinEmailHintText,
  labelStyle: TextStyle(
    color: FocusNode().hasFocus ? InputCursorColor : InputColor,
  ),
  filled: true,
  fillColor: ShowBlockColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(
      color: InputColor,
      width: TextFocusedLine,
    ),
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
);
final PasswordInputDesign = InputDecoration(
  labelText: pinCodeText,
  hintText: pinCodeHintText,
  labelStyle: TextStyle(
    color: FocusNode().hasFocus ? InputCursorColor : InputColor,
  ),
  filled: true,
  fillColor: ShowBlockColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(
      color: InputColor,
      width: TextFocusedLine,
    ),
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
);
final PassWord2InputDesign = InputDecoration(
  labelText: pinCode2Text,
  hintText: pinCodeHint2Text,
  labelStyle: TextStyle(
    color: FocusNode().hasFocus ? InputCursorColor : InputColor,
  ),
  filled: true,
  fillColor: ShowBlockColor,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
  focusedBorder:OutlineInputBorder(
    borderSide: BorderSide(
      color: InputColor,
      width: TextFocusedLine,
    ),
    borderRadius: BorderRadius.circular(BlockBorderRadius),
  ),
);
//
//傳說中的主題色
//PineappleTWTheme()
//
const Pineapple100 = Color(0xFFffdead);
const Pineapple50 = Color(0xFFFFD180);
const Pineapple300 = Colors.orangeAccent;
const Pineapple400 = Colors.orange;
const Pineapple900 = Colors.brown;
const PineappleWhite = Colors.white;
const PineappleBackgroundWhite = Colors.white;
const PineappleErrorRed = Colors.deepOrange;
final ColorScheme PineappleColor = ColorScheme(
  primary: Pineapple400,
  primaryVariant: Pineapple900,
  secondary: Pineapple100,
  secondaryVariant: Pineapple900,
  surface: PineappleWhite,
  background: Pineapple100,
  error: PineappleErrorRed,
  onPrimary: Pineapple900,
  onSecondary: Pineapple900,
  onSurface: Pineapple900,
  onBackground: Pineapple900,
  onError: PineappleWhite,
  brightness: Brightness.light,
);
ThemeData PineappleTWTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: PineappleColor,
    toggleableActiveColor: Pineapple300,
    primaryColor: Pineapple300,
    accentColor: Pineapple50,
    buttonColor: Pineapple100,
    scaffoldBackgroundColor: Pineapple100,
    cardColor: PineappleBackgroundWhite,
    errorColor: PineappleErrorRed,
    buttonTheme: ButtonThemeData(
      colorScheme: PineappleColor,
      textTheme: ButtonTextTheme.normal,
    ),
  );
}