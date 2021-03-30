import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:food_bank_auth/models/place.dart';
import 'package:food_bank_auth/screens/home/Home.dart';
import 'package:food_bank_auth/screens/home/placePage.dart';
import 'package:food_bank_auth/screens/home/placeSelect.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_bank_auth/util/dataprocess.dart';

class PostEditPage extends StatefulWidget {
  @override
  _PostEditPageState createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
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

  final postTitle = TextEditingController();
  final article = TextEditingController();
  DateTime now = DateTime.now();
  DateTime _date = DateTime.now();
  TimeOfDay _time =
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
        },
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(RaisedButtonborderRadius)),
        ),
        label: Text(
          "Library",
          overflow: TextOverflow.ellipsis,
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
          overflow: TextOverflow.ellipsis,
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
            overflow: TextOverflow.ellipsis,
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
            overflow: TextOverflow.ellipsis,
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
            controller: postTitle,
            decoration: InputDecoration(
              icon: Icon(
                Icons.fastfood,
                color: IconColor,
              ),
              labelText: TitleLabelText,
              hintText: TitleHintText,
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
            keyboardType: TextInputType.multiline,
            maxLength: ArticleMaxLength,
            maxLines: ArticleMaxLines,
            controller: article,
            cursorColor: InputColor,
            decoration: InputDecoration(
              icon: Icon(
                Icons.article,
                color: IconColor,
              ),
              labelText: ArticleLabelText,
              hintText: ArticleHelperText,
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
    //_date、_time
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
          _date = newDate;
        });
      }
      final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: _time,
      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
        });
      }
      _date = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);
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
          overflow: TextOverflow.ellipsis,
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
        "${_date.year}/${_date.month}/${_date.day}\t${_time.hour}:${_time.minute}",
        overflow: TextOverflow.ellipsis,
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
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ButtonIconColor),
        ),
        icon: Icon(
          Icons.location_on_outlined,
          color: ButtonIconColor,
        ),
        color: ButtonBGColor_Location,
      ),
    );
    Container showLocation = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowFill,
      child: Text(
        showSelectPlace,
        overflow: TextOverflow.ellipsis,
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
    final EditHelpAlert = AlertDialog(
      title: Text(
        EditHelp,
        overflow: TextOverflow.ellipsis,
      ),
      content: Text(
        EditHelp_Tips,
        // overflow: TextOverflow.ellipsis,
      ),
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
    void CheckInfo() async {
      if (_image == null ||
          postTitle.text == "" ||
          article.text == "" ||
          !_date.isAfter(DateTime.now().add(const Duration(minutes: 30)))) {
        showDialog<void>(context: context, builder: (context) => EditHelpAlert);
      } else {
        //TODO 地圖經緯度
        await DataUpload().uploadPost(
            _image,
            postTitle.text,
            article.text,
            _date,
            selectPlace.longitude,
            selectPlace.latitude,
            tagsList_O,
            selectPlace.city,
            selectPlace.district);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }

    final doubleCheck = AlertDialog(
      title: Text(ConfirmToSendText_t),
      content: Text(ConfirmToSendText_c),
      actions: [
        FlatButton(
          //Cancel
          textColor: Colors.grey,
          onPressed: () => Navigator.pop(context),
          child: Text(
            doubleCheck_X,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: wordsSize_S,
            ),
          ),
        ),
        FlatButton(
          //Yes
          textColor: Colors.orange,
          onPressed: () {
            CheckInfo();
          },
          child: Text(
            doubleCheck_O,
            overflow: TextOverflow.ellipsis,
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
        showDialog<void>(context: context, builder: (context) => doubleCheck);
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
            overflow: TextOverflow.ellipsis,
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
            overflow: TextOverflow.ellipsis,
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
            Location,
            SizedBox(height: Height_Size_L),
            ArticleEdit,
            SizedBox(height: Height_Size_L),
            ArticleTag,
            SizedBox(height: Height_Size_L),
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
