import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:food_bank_auth/models/place.dart';
import 'package:food_bank_auth/screens/home/Home.dart';
import 'package:food_bank_auth/screens/home/mainPage.dart';
import 'package:food_bank_auth/screens/home/placeSelect.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_bank_auth/util/dataprocess.dart';

class PostEditPage_Event extends StatefulWidget {
  @override
  _PostEditPage_EventState createState() => _PostEditPage_EventState();
}

class _PostEditPage_EventState extends State<PostEditPage_Event> {
  File _image;
  SelectPlace selectPlace;
  String showSelectPlace = "None";
  final _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        return cropimage();
      } else {
        print('No image selected');
      }
    });
  }

  Future cropimage() async {
    File _cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop the Photo',
          toolbarColor: ABColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    setState(() {
      _image = _cropped ?? _image;
    });
    return _image;
  }

  final eventpostTitle = TextEditingController();
  final eventarticle = TextEditingController();
  DateTime now = DateTime.now();
  DateTime _eventdate = DateTime.now();
  TimeOfDay _eventtimeSTART =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay _eventtimeEND =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  List<String> tagsList = [
    "pineapple",
    "sour",
    "sweet",
    "bitter",
    "spicy",
    "salty",
    "seafood",
    "fruit",
    "vegetable",
    "seasonings",
    "beverage",
    "dessert",
    "daytime",
    "afternoon",
    "night",
    "midnight",
    "liqueur",
    "wine",
  ]; //list of all tags
  List<String> tagsList_O = []; //list of chosen value

  @override
  Widget build(BuildContext context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;

    //_image
    final presetPhoto = Container(
      child: Image(image: AssetImage('images/noPhoto.png')),
    );
    final fromLibrary = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        elevation: 0.0,
        onPressed: () {
          getImage(ImageSource.gallery); //return _image
          // Uploader(file: _image);
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(RaisedButtonborderRadius)),
        ),
        label: Text(
          "Library",
          style: TextStyle(
            color: ButtonIconColor,
          ),
        ),
        icon: Icon(
          Icons.photo_library,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Photo,
      ),
    );
    final fromCamera = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        elevation: 0.0,
        onPressed: () {
          getImage(ImageSource.camera); //return _image
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(RaisedButtonborderRadius)),
        ),
        label: Text(
          "Camera",
          style: TextStyle(
            color: ButtonIconColor,
          ),
        ),
        icon: Icon(
          Icons.photo_camera,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Photo,
      ),
    );
    final DeleteCheck = AlertDialog(
      title: Text(PhotoDeleteText_t),
      content: Text(PhotoDeleteText_c),
      actions: [
        FlatButton(
          //Yes
          textColor: Colors.grey,
          onPressed: () {
            setState(() {
              _image = null;
            });
            Navigator.pop(context);
          },
          child: Text(
            doubleCheck_O,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Cancel
          textColor: Colors.orange,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            doubleCheck_X,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final DeletePhoto = RawMaterialButton(
      fillColor: AddEventBtnColor,
      shape: CircleBorder(),
      child: Icon(
        Icons.cancel,
        color: AddEventBtnIconColor,
      ),
      onPressed: () {
        if (_image != null) {
          showDialog<void>(context: context, builder: (context) => DeleteCheck);
        }
      },
    );
    final HowToGetPhoto = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 45,
            child: fromLibrary,
          ),
          Expanded(
            flex: 10,
            child: DeletePhoto,
          ),
          Expanded(
            flex: 45,
            child: fromCamera,
          ),
        ]);

    //tag???
    final TagIcon = Icon(
      Icons.tag,
      color: IconColor,
    );
    final HashTag = Container(
      //padding: const EdgeInsets.all(0.0),
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
    );
    final ArticleTag = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TagIcon,
        HashTag,
      ],
    );
    //postTitle.text、article.text
    final ArticleEdit = Container(
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(
              color: InputColor,
            ),
            cursorColor: InputColor,
            maxLength: TitleMaxLength,
            controller: eventpostTitle,
            decoration: InputDecoration(
              icon: Icon(
                Icons.fastfood,
                color: IconColor,
              ),
              labelText: Event_TitleLabelText,
              hintText: Event_TitleHintText,
              labelStyle: TextStyle(
                  color: FocusNode().hasFocus ? InputCursorColor : InputColor),
              filled: true,
              fillColor: TextFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BlockBorderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: InputColor,
                  width: TextFocusedLine,
                ),
                borderRadius: BorderRadius.circular(BlockBorderRadius),
              ),
            ),
          ),
          SizedBox(height: Height_Size_L),
          TextFormField(
            style: TextStyle(
              color: InputColor,
            ),
            maxLength: ArticleMaxLength,
            keyboardType: TextInputType.multiline,
            maxLines: ArticleMaxLines,
            controller: eventarticle,
            cursorColor: InputColor,
            decoration: InputDecoration(
              icon: Icon(
                Icons.article,
                color: IconColor,
              ),
              labelText: Event_ArticleLabelText,
              hintText: Event_ArticleHelperText,
              labelStyle: TextStyle(
                  color: FocusNode().hasFocus ? InputCursorColor : InputColor),
              filled: true,
              fillColor: TextFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BlockBorderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: InputColor,
                  width: TextFocusedLine,
                ),
                borderRadius: BorderRadius.circular(BlockBorderRadius),
              ),
            ),
          ),
        ],
      ),
    );
    //_eventdate
    void _selectDate() async {
      final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, now.month),
        lastDate: DateTime(2030, 07),
        helpText: ExpirationDateText,
      );
      if (newDate != null) {
        setState(() {
          _eventdate = newDate;
        });
      }
      _eventdate = DateTime(_eventdate.year, _eventdate.month, _eventdate.day);
    }

    final setDate = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: _selectDate,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
        label: Text(
          ExpirationDateText,
          style: TextStyle(color: ButtonIconColor),
        ),
        icon: Icon(
          Icons.date_range_outlined,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Date,
      ),
    );
    final showDate = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowFill,
      child: Text(
        "${_eventdate.year}/${_eventdate.month}/${_eventdate.day}",
        style: TextStyle(
          color: InputCursorColor,
          fontSize: wordsSize_S,
        ),
      ),
    );
    final Date = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 16, // 40%
            child: setDate,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 23, // 60%
            child: showDate,
          ),
        ]);
    //_eventtimeSTART、_eventtimeEND
    void _selectTimeS() async {
      final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: _eventtimeSTART,
      );
      if (newTime != null) {
        setState(() {
          _eventtimeSTART = newTime;
        });
      }
      _eventtimeSTART =
          TimeOfDay(hour: _eventtimeSTART.hour, minute: _eventtimeSTART.minute);
    }

    final setTimeS = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: _selectTimeS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
        label: Text(
          Event_TimeStart,
          style: TextStyle(color: ButtonIconColor),
        ),
        icon: Icon(
          Icons.more_time_outlined,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Date,
      ),
    );
    final showTimeS = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowFill,
      child: Text(
        "${_eventtimeSTART.hour} : ${_eventtimeSTART.minute}",
        style: TextStyle(
          color: InputCursorColor,
          fontSize: wordsSize_S,
        ),
      ),
    );
    final Time_start = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 16, // 40%
            child: setTimeS,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 23, // 60%
            child: showTimeS,
          ),
        ]);
    void _selectTimeE() async {
      final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: _eventtimeEND,
      );
      if (newTime != null) {
        setState(() {
          _eventtimeEND = newTime;
        });
      }
      _eventtimeEND =
          TimeOfDay(hour: _eventtimeEND.hour, minute: _eventtimeEND.minute);
    }

    final setTimeE = Container(
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: _selectTimeE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
        label: Text(
          Event_TimeEnd,
          style: TextStyle(color: ButtonIconColor),
        ),
        icon: Icon(
          Icons.access_time_sharp,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Date,
      ),
    );
    final showTimeE = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowFill,
      child: Text(
        "${_eventtimeEND.hour} : ${_eventtimeEND.minute}",
        style: TextStyle(
          color: InputCursorColor,
          fontSize: wordsSize_S,
        ),
      ),
    );
    final Time_end = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 16, // 40%
            child: setTimeE,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 23, // 60%
            child: showTimeE,
          ),
        ]);
    //foodLocation、RealLocationText(縣市名)
    void _selectLocation() async {
      selectPlace = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => placeSelect()));
      setState(() {
        if (selectPlace.allLocation == "") {
          showSelectPlace = "None";
        }
        selectPlace = selectPlace;
        showSelectPlace =
            "${selectPlace.city}${selectPlace.district}${selectPlace.street}";
      });
    } //TODO 食物地點 Link to GoogleMap

    final setLocation = Container(
      //width: SettingButton_Width,
      height: SettingButton_Height,
      child: RaisedButton.icon(
        onPressed: _selectLocation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(RaisedButtonborderRadius),
          ),
        ),
        label: Text(
          LocationText,
          style: TextStyle(color: ButtonIconColor),
        ),
        icon: Icon(
          Icons.location_on_outlined,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Location,
      ),
    );
    final showLocation = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowFill,
      child: Text(
        showSelectPlace,
        style: TextStyle(
          color: InputCursorColor,
          fontSize: wordsSize_S,
        ),
      ),
    );
    final Location = Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 16,
          child: setLocation,
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 23,
          child: showLocation,
        ),
      ],
    );

    //Send
    final Event_EditHelpAlert = AlertDialog(
      title: Text(EditHelp),
      content: Text(Event_EditHelp_Tips),
      actions: [
        FlatButton(
          textColor: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            EditHelpAlertText,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    void Event_CheckInfo() async {
      //有照片、標題不為空、內容不為空、提前一天、時間合理(至少半小時)
      double doubleTimeE = _eventtimeEND.hour.toDouble() +
          (_eventtimeEND.minute.toDouble() / 60);
      double doubleTimeS = _eventtimeSTART.hour.toDouble() +
          (_eventtimeSTART.minute.toDouble() / 60);
      if (_image == null ||
          eventpostTitle.text == "" ||
          eventarticle.text == "" ||
          !_eventdate.isAfter(DateTime.now().add(const Duration(days: 1))) ||
          doubleTimeE <= doubleTimeS + 0.5) {
        showDialog<void>(
            context: context, builder: (context) => Event_EditHelpAlert);
      } else {
        //TODO linked MAP
        DateTime _eventdateS = DateTime(_eventdate.year, _eventdate.month,
            _eventdate.day, _eventtimeSTART.hour, _eventtimeSTART.minute);
        DateTime _eventdateE = DateTime(_eventdate.year, _eventdate.month,
            _eventdate.day, _eventtimeEND.hour, _eventtimeEND.minute);
        await DataUpload().uploadEvent(
            _image,
            eventpostTitle.text,
            eventarticle.text,
            _eventdateS,
            _eventdateE,
            selectPlace.longitude,
            selectPlace.latitude,
            selectPlace.city,
            selectPlace.district,
            tagsList_O);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }

    final Event_doubleCheck = AlertDialog(
      title: Text(ConfirmToSendText_t),
      content: Text(ConfirmToSendText_c),
      actions: [
        FlatButton(
          //Cancel
          textColor: Colors.grey,
          onPressed: () => Navigator.pop(context),
          child: Text(
            doubleCheck_X,
            style: new TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Yes
          textColor: Colors.orange,
          onPressed: () {
            Event_CheckInfo();
          },
          child: Text(
            doubleCheck_O,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final AppBarSendBtn = IconButton(
      icon: Icon(
        Icons.check,
        color: Colors.white,
        size: ABIconSize,
      ),
      onPressed: () {
        showDialog<void>(
            context: context, builder: (context) => Event_doubleCheck);
      },
    );
    //Cancel
    final CancelToEdit = AlertDialog(
      title: Text(CancelAlertText_t),
      content: Text(CancelAlertText_c),
      actions: [
        FlatButton(
          //Cancel
          textColor: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            doubleCheck_X,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Yes
          textColor: Colors.orange,
          onPressed: () => Navigator.pop(context),
          child: Text(
            EditHelpAlertText,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
      ],
    );
    final AppBarCancelBtn = IconButton(
      icon: Icon(
        Icons.west_outlined,
        color: Colors.deepOrange,
        size: ABIconSize,
      ),
      onPressed: () {
        showDialog<void>(context: context, builder: (context) => CancelToEdit);
      },
    );
    final pinePhoto = Container(
      width: 30,
      height: 30,
      child: Image(image: AssetImage('images/ic_launcher_smile.png')),
    );

    return Scaffold(
      backgroundColor: BGColor,
      appBar: AppBar(
        backgroundColor: ABColor,
        elevation: 0.0,
        leading: AppBarCancelBtn,
        actions: [
          pinePhoto,
          AppBarSendBtn,
          SizedBox(width: Width_Size_S),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            vertical: paddingNum,
            horizontal: paddingNum,
          ),
          children: <Widget>[
            if (_image != null) ...[
              Image.file(_image),
            ],
            if (_image == null) ...[
              presetPhoto,
            ],
            SizedBox(height: Height_Size_L),
            HowToGetPhoto,
            SizedBox(height: Height_Size_L),
            Date,
            SizedBox(height: Height_Size_L),
            Time_start,
            SizedBox(height: Height_Size_L),
            Time_end,
            SizedBox(height: Height_Size_L),
            Location,
            SizedBox(height: Height_Size_L),
            ArticleEdit,
            SizedBox(height: Height_Size_L),
            ArticleTag,
            SizedBox(height: Height_Size_L),
            //ConfirmToSend,
          ],
        ),
      ),
    );
  }
}

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
      color: TagBG,
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
