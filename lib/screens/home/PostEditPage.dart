import 'package:firebase_ml_custom/firebase_ml_custom.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

class PostEditPage extends StatefulWidget {
  @override
  _PostEditPageState createState() => _PostEditPageState();
}
class _PostEditPageState extends State<PostEditPage> {
  // var  lastPopTime = DateTime.now();
  // int needTime = 5;//發文至少間隔五秒
  bool loading = false;
  bool _isFood = false;
  File _image;
  SelectPlace selectPlace;
  String showSelectPlace = "None";
  final _picker = ImagePicker();
  //取得Img

  @override
  void initState() {
    super.initState();
    loadOnlineModel().then((value) {
      print("Done!---------");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  static Future<String> loadOnlineModel() async {
    print("...loadOnlineModel...");
    final modelFile = await loadModelFromFirebase();
    return loadTFLiteModel(modelFile);
  }
  static Future<File> loadModelFromFirebase() async {
    try {
      // final model = FirebaseCustomRemoteModel('fruitsDetector');
      final model = FirebaseCustomRemoteModel('fruitsDetector'); //Version 2:AutoML
      final conditions = FirebaseModelDownloadConditions(
          androidRequireWifi: true, iosAllowCellularAccess: false);
      final modelManager = FirebaseModelManager.instance;
      await modelManager.download(model, conditions);
      assert(await modelManager.isModelDownloaded(model) == true);
      var modelFile = await modelManager.getLatestModelFile(model);
      assert(modelFile != null);
      return modelFile;
    } catch (exception) {
      print('Failed on loading your model from Firebase: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }

  static Future<String> loadTFLiteModel(File modelFile) async {
    try {
      print(".....loadTFLiteModel.... Model File Path: ${modelFile.path}");
      final appDirectory = await getApplicationDocumentsDirectory();
      final labelsData =
      await rootBundle.load('assets/labels.txt');
      final labelsFile =
      await File('${appDirectory.path}/_labels.txt')
          .writeAsBytes(labelsData.buffer.asUint8List(
          labelsData.offsetInBytes, labelsData.lengthInBytes));
      await Tflite.loadModel(
          model: modelFile.path, labels: labelsFile.path, isAsset:false);
      return 'Model is loaded';
    } catch (exception) {
      print(
          'Failed on loading your model to the TFLite interpreter: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }

  Future<dynamic> classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 36,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return output;
  }

  Future<String> imageDetector(File source) async{
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(source);
    final ImageLabeler cloudLabeler =
    FirebaseVision.instance.cloudImageLabeler();
    final List<ImageLabel> cloudLabels =
    await cloudLabeler.processImage(visionImage);
    for (ImageLabel label in cloudLabels) {
      // final double confidence = label.confidence;
      // print("label:${label.text}");
      if(label.text == "Food"){
        dynamic result = await classifyImage(source);
        _isFood = true;
        return (result==null)?"Food":result[0]["label"];
      }else if(label.text == "Fruit"){
        dynamic result = await classifyImage(source);
        _isFood = true;
        return (result==null)?"Fruit":result[0]["label"];
      }
    }
    cloudLabeler.close();

    _isFood = false;

    return cloudLabels[0].text;
  }

  Future<File> getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {

      });
      return cropimage();
    } else {
      print('No image selected');
    }
  }
  //裁切(固定比例1:1)
  Future<File> cropimage() async {
    File _cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
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
  String defaultPostTitle = "None";
  final article = TextEditingController();
  DateTime now = DateTime.now();
  DateTime _date = DateTime.now();
  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  List<String> tagsList_O = []; //list of chosen value

  @override
  Widget build(BuildContext context) {
    final postTitle = TextEditingController(text: defaultPostTitle);
    final paddingNum = MediaQuery.of(context).size.width / 14;

    //_image
    final fromLibrary = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () async{
          File cropFile = await getImage(ImageSource.gallery);
          String result = await imageDetector(cropFile);
          showDialog<void>(context: context, builder: (context) {
            return !_isFood?AlertDialog(
              title: Text("This is not a Food!"),
              content: Text("Please upload a true food!"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      defaultPostTitle = "None";
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok, I know",
                    style: DiaOptDesign[1],
                  ),
                ),
              ],
            ):AlertDialog(
              title: Text("Is it correct?"),
              content: Container(
                height: 60,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Our detect result: "),
                        Text(" ${result}",
                        style:TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("If you select 'Yes', we will auto fill the title.")
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      defaultPostTitle = result;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                   "Yes",
                    style: DiaOptDesign[1],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      defaultPostTitle = "None";
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: DiaOptDesign[0],
                  ),
                ),
              ],
            );
          });
        },
        style: PhotoBtnDesign,
        label: PhotoLibraryBtnText,
        icon: PhotoLibraryBtnIcon,
      ),
    );
    final fromCamera = Container(
      height: SettingButton_Height,
      child: ElevatedButton.icon(
        onPressed: () async{
          File cropFile = await getImage(ImageSource.camera);
          String result = await imageDetector(cropFile);
          showDialog<void>(context: context, builder: (context) {
            return !_isFood?AlertDialog(
              title: Text("This is not a Food!"),
              content: Text("Please upload a true food!"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      defaultPostTitle = "None";
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok, I know",
                    style: DiaOptDesign[1],
                  ),
                ),
              ],
            ):AlertDialog(
              title: Text("Is it correct?"),
              content: Container(
                height: 60,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Our detect result: "),
                        Text(" ${result}",
                            style:TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("If you select 'Yes', we will auto fill the title.")
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      defaultPostTitle = result;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yes",
                    style: DiaOptDesign[1],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      defaultPostTitle = "None";
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: DiaOptDesign[0],
                  ),
                ),
              ],
            );
          });

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
            controller: postTitle,
            maxLength: TitleMaxLength,
            style: InputBlockDesign[0],
            cursorColor: InputColor,
            decoration: ArticleTitleBlockDesign,
          ),
          SizedBox(height: Height_Size_L),
          TextFormField(
            controller: article,
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
      child: ElevatedButton.icon(
        onPressed: _selectDate,
        style: DateBtnDesign,
        label: DateBtnText,
        icon: DateBtnIcon,
      ),
    );
    final showDate = Container(
      child:Text(
        "${_date.year}/${_date.month}/${_date.day}\t${_time.hour}:${_time.minute}",
        overflow: TextOverflow.ellipsis,
        style: InputBlockDesign[1],
      ),
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
    );
    final Date = Row(
        children: <Widget>[
          Expanded(
            flex: 16,
            child: setDate,
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 23,
            child: showDate,
          ),
        ]
    );

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
      child:Text(
        showSelectPlace,
        overflow: TextOverflow.ellipsis,
        style: InputBlockDesign[1],
      ),
      height: ShowWords_Height,
      alignment: Alignment.center,
      color: ShowBlockColor,
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

    //AppBar_Cancel/Send
    final EditHelpAlert = AlertDialog(
      title: Text(
        EditHelp,
        style: DiaTitleStyle,
      ),
      content: Text(
        EditHelp_Tips,
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
    void CheckInfo() async {
      // if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)){
        // print(lastPopTime);
        // lastPopTime = DateTime.now();
        // print("允許上傳，檢查欄位...");
        // 有照片、地點、標題和內容不為空、提前30分鐘
        if (_image == null ||
            postTitle.text == "" ||
            article.text == "" ||
            showSelectPlace ==""||
            !_date.isAfter(DateTime.now().add(const Duration(minutes: 30)))) {
          showDialog<void>(context: context, builder: (context) => EditHelpAlert);
          setState(() {loading = false;});
        } else {
          setState(() {
            loading = true;
            Navigator.pop(context);
          });
          //TODO 改變貼文狀態 公開
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
        }
      // }else{
      //   // print("請勿重複上傳！");
      // }
    }

    final doubleCheck = AlertDialog(
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
            CheckInfo();
          },
          child: doubleCheckText[1],
        ),
      ],
    );
    final AppBarSendBtn = IconButton(
      icon: DoneIcon,
      onPressed: (){
        showDialog<void>(context: context, builder: (context) => doubleCheck);
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
            if (_image == null) ...[
              presetNoPhoto,
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