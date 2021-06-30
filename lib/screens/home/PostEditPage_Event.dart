import 'package:flutter/material.dart';
import 'package:food_bank_auth/util/loading.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:food_bank_auth/models/place.dart';
import 'package:food_bank_auth/screens/home/placeSelect.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class PostEditPage_Event extends StatefulWidget {

  @override
  _PostEditPage_EventState createState() => _PostEditPage_EventState();
}

class _PostEditPage_EventState extends State<PostEditPage_Event> {
  // var lastPopTime = DateTime.now();
  // int needTime = 5;//發文至少間隔五秒
  bool loading = false;
  File _image;
  SelectPlace selectPlace;
  String showSelectPlace = "None";
  final _picker = ImagePicker();
  //取得Img
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
  //裁切(固定比例1:1)
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
          toolbarColor: Pineapple300,
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
  TimeOfDay _eventtimeSTART = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TimeOfDay _eventtimeEND = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  List<String> tagsList_O = []; //list of chosen value

  @override
  Widget build(BuildContext context) {
    final paddingNum = MediaQuery.of(context).size.width / 14;

    //_image
    final fromLibrary = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () {
          getImage(ImageSource.gallery);//return _image
        },
        style: PhotoBtnDesign,
        label: PhotoLibraryBtnText,
        icon: PhotoLibraryBtnIcon,
      ),
    );
    final fromCamera = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () {
          getImage(ImageSource.camera);//return _image
        },
        style: PhotoBtnDesign,
        label: PhotoCameraBtnText,
        icon: PhotoCameraBtnIcon,
      ),
    );
    final DeleteCheck =  AlertDialog(
      title: Text(
        PhotoDeleteText_t,
        style: DiaTitleStyle,
      ),
      content: Text(
        PhotoDeleteText_c,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _image = null;
            });
            Navigator.pop(context);
          },
          child: Text(
            doubleCheck_O,
            style: DiaOptDesign[0],
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            doubleCheck_X,
            style: DiaOptDesign[1],
          ),
        ),
      ],
    );
    final DeletePhoto = RawMaterialButton(
      fillColor: AddEventBtnColor,
      shape: CircleBorder(),
      child: XIcon,
      onPressed: () {
        if (_image != null) {
          showDialog<void>(context: context, builder: (context) => DeleteCheck);
        }
      },
    );
    final HowToGetPhoto = Row(
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
        ]
    );

    //tag???
    final HashTag = Container(
      child: Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[
            Content(
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
            controller: eventpostTitle,
            maxLength: TitleMaxLength,
            style: InputBlockDesign[0],
            cursorColor: InputColor,
            decoration: ArticleTitleBlockDesign,
          ),
          SizedBox(height: Height_Size_L),
          TextFormField(
            controller: eventarticle,
            keyboardType: TextInputType.multiline,
            maxLength: ArticleMaxLength,
            maxLines: ArticleMaxLines,
            style: InputBlockDesign[0],
            cursorColor: InputColor,
            decoration: ArticleTextBlockDesign,
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
      child: ElevatedButton.icon(
        onPressed: _selectDate,
        style: DateBtnDesign,
        label: EventDateBtnText,
        icon: DateBtnIcon,
      ),
    );
    final showDate = Container(
      child:Text(
        "${_eventdate.year}/${_eventdate.month}/${_eventdate.day}",
        style: InputBlockDesign[1],
      ),
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
    );
    final Date = Row(
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
      child: ElevatedButton.icon(
        onPressed: _selectTimeS,
        style: DateBtnDesign,
        label: EventTimeSBtnText,
        icon: EventTimeSBtnIcon,
      ),
    );
    final showTimeS = Container(
      child:Text(
        "${_eventtimeSTART.hour} : ${_eventtimeSTART.minute}",
        style: InputBlockDesign[1],
      ),
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
    );
    final Time_start = Row(
        children: <Widget>[
          Expanded(
            flex: 16,
            child: setTimeS,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 23,
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
      child: ElevatedButton.icon(
        onPressed: _selectTimeE,
        style: DateBtnDesign,
        label: EventTimeEBtnText,
        icon: EventTimeEBtnIcon,
      ),
    );
    final showTimeE = Container(
      child:Text(
        "${_eventtimeEND.hour} : ${_eventtimeEND.minute}",
        style: InputBlockDesign[1],
      ),
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
    );
    final Time_end = Row(
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
    }
    final setLocation = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: _selectLocation,
        style: LocationBtnDesign,
        label: LocationBtnText,
        icon: LocationBtnIcon,
      ),
    );
    final showLocation = Container(
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
      child:Text(
        showSelectPlace,
        style: InputBlockDesign[1],
      ),
    );
    final Location = Row(
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
      title: Text(
        EditHelp,
        style: DiaTitleStyle,
      ),
      content: Text(
        Event_EditHelp_Tips,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            EditHelpAlertText,
            style: DiaOptDesign[0],
          ),
        ),
      ],
    );
    void Event_CheckInfo() async {
      // if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)){
        // print(lastPopTime);
        // lastPopTime = DateTime.now();
        // print("允許上傳，檢查欄位...");
        // 有照片、地點、標題和內容不為空、提前一天、時間合理(至少半小時)
        double doubleTimeE = _eventtimeEND.hour.toDouble() +
            (_eventtimeEND.minute.toDouble() / 60);
        double doubleTimeS = _eventtimeSTART.hour.toDouble() +
            (_eventtimeSTART.minute.toDouble() / 60);
        if (_image == null ||
            eventpostTitle.text == "" ||
            eventarticle.text == "" ||
            showSelectPlace ==""||
            !_eventdate.isAfter(DateTime.now().add(const Duration(days: 1))) ||
            doubleTimeE <= doubleTimeS + 0.5) {
          showDialog<void>(context: context, builder: (context) => Event_EditHelpAlert);
          setState(() {loading = false;});
        } else {
          setState(() {
            loading = true;
            Navigator.pop(context);
          });
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
        }
      // }else{
      //   //print("請勿重複上傳！");
      // }
    }
    final Event_doubleCheck = AlertDialog(
      title: Text(
        ConfirmToSendText_t,
        style: DiaTitleStyle,
      ),
      content: Text(
        ConfirmToSendText_c,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: doubleCheckText[0],
        ),
        TextButton(
          onPressed: () {
            Event_CheckInfo();
          },
          child: doubleCheckText[1],
        ),
      ],
    );
    final AppBarSendBtn = IconButton(
      icon: DoneIcon,
      onPressed: (){
        showDialog<void>(context: context, builder: (context) => Event_doubleCheck);
      },
    );
    final CancelToEdit = AlertDialog(
      title: Text(
        CancelAlertText_t,
        style: DiaTitleStyle,
      ),
      content: Text(
        CancelAlertText_c,
        style: DiaConStyle,
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: doubleCheckText[0],
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            EditHelpAlertText,
            style: DiaOptDesign[1],
          ),
        ),
      ],
    );
    final AppBarCancelBtn = IconButton(
      icon: BackIcon,
      onPressed: () {
        showDialog<void>(context: context, builder: (context) => CancelToEdit);
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: AppBarCancelBtn,
        actions: [
          pinePhoto,
          AppBarSendBtn,
          SizedBox(width: Width_Size_S),
        ],
      ),
      body: loading ? Loading() : GestureDetector(
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
            if(_image == null)  ...[
              presetNoPhoto,
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
