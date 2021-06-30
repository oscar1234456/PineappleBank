import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/constants.dart';
import 'package:food_bank_auth/util/loading.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key key,
    @required this.post_id,
    @required this.peer_id,
    @required this.isProvider,
    @required this.foodName,
  }) : super(key: key);
  final post_id;
  final String peerAvatar = "null";
  final peer_id;
  final isProvider;
  final foodName;
  //final foodName;
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.foodName}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ChatScreen(peerId: widget.peer_id, post_Id: widget.post_id, isProvider:widget.isProvider),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key, @required this.peerId, @required this.post_Id, @required this.isProvider}) : super(key: key);
  final String peerId;
  final String post_Id;
  final String peerAvator ="null";
  final bool isProvider;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // _ChatScreenState({Key? key, required this.peerId, required this.peerAvatar});
  // final String peerId;
  // final String peerAvatar;
  String id = FirebaseAuth.instance.currentUser.uid;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  int _limitIncrement = 20;
  // late String groupChatId;
  // late SharedPreferences prefs;

  // late File imageFile;
  bool isLoading = true;
  bool isShowSticker = false;
  // late String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    // groupChatId = '';
    isLoading = false;
    isShowSticker = false;
    // imageUrl = '';
    print("init: peer_id = idTo: ${widget.peerId}");
    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    // prefs = await SharedPreferences.getInstance();
    // id = prefs.getString('id') ?? '';
    // if (id.hashCode <= peerId.hashCode) {
    //   groupChatId = '$id-$peerId';
    // } else {
    //   groupChatId = '$peerId-$id';
    // }

    FirebaseFirestore.instance.collection('user').doc(id).update({'chattingWith': widget.peerId});

    setState(() {});
  }

  // Future getImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   PickedFile? pickedFile;
  //
  //   pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
  //   imageFile = File(pickedFile!.path);
  //
  //   if (imageFile != null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     uploadFile();
  //   }
  // }

  // void getSticker() {
  //   // Hide keyboard when sticker appear
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  // Future uploadFile() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference reference = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask uploadTask = reference.putFile(imageFile);
  //   // StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  //   TaskSnapshot snapshot = await uploadTask;
  //   snapshot.ref.getDownloadURL().then((downloadUrl) {
  //     imageUrl = downloadUrl;
  //     setState(() {
  //       isLoading = false;
  //       onSendMessage(imageUrl, 1);
  //     });
  //   }, onError: (err) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: 'This file is not an image');
  //   });
  // }
  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();
      SendMsg sender = SendMsg();
      sender.sendMessage(widget.post_Id, widget.peerId, content, widget.isProvider);
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      print("Finish onSendMessage, print ${content}");
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    final WindowW = MediaQuery.of(context).size.width;
    final MsgBoxMaxW = WindowW * 8 / 10; //訊息寬度不超過螢幕寬的80%
    if (document['idFrom'] == id) {
      print("myMessage");
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
          // Text
          ? Container(//自己傳的訊息
            child: Text(
              document['content'],
              style: myMsgTextDesign,
            ),
            padding: MsgBoxPadding,
            margin: myMsgBoxMargin,
            decoration: myMsgBoxDesign,
            constraints: BoxConstraints(maxWidth: MsgBoxMaxW),
          )
          : document['type'] == 1
          // Image
          ? Container(
            child: TextButton(
              child: Material(
                // child: CachedNetworkImage(
                //   placeholder: (context, url) => Container(
                //     child: CircularProgressIndicator(
                //       valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                //     ),
                //     width: 200.0,
                //     height: 200.0,
                //     padding: EdgeInsets.all(70.0),
                //     decoration: BoxDecoration(
                //       color: greyColor2,
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(8.0),
                //       ),
                //     ),
                //   ),
                //   errorWidget: (context, url, error) => Material(
                //     child: Image.asset(
                //       'images/img_not_available.jpeg',
                //       width: 200.0,
                //       height: 200.0,
                //       fit: BoxFit.cover,
                //     ),
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(8.0),
                //     ),
                //     clipBehavior: Clip.hardEdge,
                //   ),
                //   imageUrl: document['content'],
                //   width: 200.0,
                //   height: 200.0,
                //   fit: BoxFit.cover,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                clipBehavior: Clip.hardEdge,
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
              },
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
          // Sticker
          : Container(
            child: Image.asset(
              'images/${document['content']}.gif',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      print("myMessage2");
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                ? Material(
                  // child: CachedNetworkImage(
                  //   placeholder: (context, url) => Container(
                  //     child: CircularProgressIndicator(
                  //       strokeWidth: 1.0,
                  //       valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  //     ),
                  //     width: 35.0,
                  //     height: 35.0,
                  //     padding: EdgeInsets.all(10.0),
                  //   ),
                  //   imageUrl: peerAvatar,
                  //   width: 35.0,
                  //   height: 35.0,
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(18.0),),
                  clipBehavior: Clip.hardEdge,
                )
                : Container(width: 0.0),//拿掉之後無法顯示有表情貼的訊息
                document['type'] == 0
                ? Container(
                  child: Text(
                    document['content'],
                    style: MsgTextDesign,
                  ),
                  padding: MsgBoxPadding,
                  decoration: MsgBoxDesign,
                  constraints: BoxConstraints(maxWidth: MsgBoxMaxW),
                  margin: EdgeInsets.only(left: 10.0),
                )
                : document['type'] == 1
                ? Container(
                  child: TextButton(
                    child: Material(
                      // child: CachedNetworkImage(
                      //   placeholder: (context, url) => Container(
                      //     child: CircularProgressIndicator(
                      //       valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      //     ),
                      //     width: 200.0,
                      //     height: 200.0,
                      //     padding: EdgeInsets.all(70.0),
                      //     decoration: BoxDecoration(
                      //       color: greyColor2,
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(8.0),
                      //       ),
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) => Material(
                      //     child: Image.asset(
                      //       'images/img_not_available.jpeg',
                      //       width: 200.0,
                      //       height: 200.0,
                      //       fit: BoxFit.cover,
                      //     ),
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(8.0),
                      //     ),
                      //     clipBehavior: Clip.hardEdge,
                      //   ),
                      //   imageUrl: document['content'],
                      //   width: 200.0,
                      //   height: 200.0,
                      //   fit: BoxFit.cover,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                          // MaterialPageRoute(
                          //     builder: (context) => FullPhoto(url: document['content'])));
                    },
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                )
                : Container(
                  child: Image.asset(
                    'images/${document['content']}.gif',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
              ],
            ),
            // Time
            isLastMessageLeft(index)
            ? Container(
              child: Text(
                DateFormat('dd MMM kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']),),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 12.0, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
            : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != id) || index == 0) {
      print("now isLastMessageRight: ${index} ");
      return true;
    } else {
      return false;
    }
  }
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      print("Back Press");
      FirebaseFirestore.instance.collection('user').doc(id).update({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),
              // Sticker
              (isShowSticker ? buildSticker() : Container()),
              // Input content
              buildInput(),
            ],
          ),
          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  //TODO 調UI
  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: Image.asset(
                  'images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: Image.asset(
                  'images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: Image.asset(
                  'images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: Image.asset(
                  'images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: Image.asset(
                  'images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: Image.asset(
                  'images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ?  Loading() : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          SizedBox(width: Width_Size_S),
          Material(
            child: Container(
              child: IconButton(
                icon: MsgInputBlockIcon[0],
                // onPressed: getImage,
              ),
            ),
          ),
          Material(
            child: Container(
              child: IconButton(
                icon: MsgInputBlockIcon[1],
                // onPressed: getSticker,
              ),
            ),
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
                style: TextStyle(color: Pineapple900, fontSize: 16.0,),
                controller: textEditingController,
                cursorColor: InputCursorColor,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: FocusNode().hasFocus ? InputCursorColor : InputColor
                  ),
                  focusedBorder: MsgInputBlockBoard,
                  hintText: 'Type your message...',
                  hintStyle: InputBlockDesign[1],
                ),
                focusNode: focusNode,
              ),
            ),
          ),
          // Button send message
          Material(
            child: Container(
              child: IconButton(
                icon: MsgInputBlockIcon[2],
                onPressed: () => onSendMessage(textEditingController.text, 0),
              ),
            ),
          ),
          SizedBox(width: Width_Size_S),
        ],
      ),
      width: double.infinity,
      height: 60.0,
      decoration: MsgInputBlockDesign,
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: widget.peerId == ''
      ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Pineapple400),
        ),
      )
      : StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('message')
            .doc(widget.post_Id)
            .collection(widget.post_Id)
            .doc(widget.isProvider?widget.peerId:id)
            .collection(widget.isProvider?widget.peerId:id)
            .orderBy('timestamp', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
          print("i am in buildListMessage builder");
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Pineapple400),
              ),
            );
          } else {
            var list = snapshot.data;
            if(list!=null){
              listMessage.addAll(list.docs);
              print("_limit: $_limit");
              print("listMessage: $listMessage");
              return ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, index) => buildItem(index, list.docs[index]),
                itemCount: list.docs.length,
                reverse: true,
                controller: listScrollController,
              );
            }else{
              return Container();
            }
          }
        },
      ),
    );
  }
}