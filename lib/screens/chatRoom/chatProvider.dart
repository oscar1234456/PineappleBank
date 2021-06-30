import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/chatRoom/charProviderPick.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/loading.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class ChatProviderWindow extends StatefulWidget {
  const ChatProviderWindow({Key key}) : super(key: key);

  @override
  _ChatProviderWindowState createState() =>
      _ChatProviderWindowState();
}

class _ChatProviderWindowState extends State<ChatProviderWindow> {
  _ChatProviderWindowState({Key key});

  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  Future getPostIdFromUser;
  final ScrollController listScrollController = ScrollController();
  final _auth = FirebaseAuth.instance;
  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPostIdFromUser = getPostIdFromUserFunc();
    // registerNotification(); //Android need not to register
    // configLocalNotification();
    listScrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  Future<bool> onBackPress() {
    // openDialog();
    Navigator.pop(context);
    return Future.value(false);
  }
  Future<List<dynamic>> getPostIdFromUserFunc() async{
    var PostidArray;
    DataFetch s = DataFetch();
    PostidArray = await s.fetchUserPostList();
    print(PostidArray);
    return PostidArray;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Stack(
          children: <Widget>[
            // List
            Container(
              child:FutureBuilder(
                future: getPostIdFromUser,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    print("You are in builder: ${snapshot.data}");
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return buildItem(context, snapshot.data[index]);
                      },
                      itemCount: snapshot.data.length,
                      controller: listScrollController,
                    );
                    return Container(child:Text("444"));
                  }else{
                    return Loading();
                  }
                }
              )
            ),
            // Loading
            Positioned(
              child: isLoading ? Loading() : Container(),
            ),
          ],
        ),
        onWillPop: onBackPress,
      );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    final WindowW = MediaQuery.of(context).size.width;
    final PineRadius = WindowW * 1 / 9;
    print("I am buildItem");
    print("my document[id]: ${document['introduction']}");
    if (document['name'] == _auth.currentUser.uid) {
      return Container();
    } else {
      return Container(
        child: TextButton(
          child: Row(
            children: <Widget>[
              Material(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: PineRadius,
                      height: PineRadius,
                      decoration: chatBoxAppIconDesign[0],
                    ),
                    Container(
                      width: PineRadius - 8,
                      height: PineRadius - 8,
                      decoration: chatBoxAppIconDesign[1],
                    ),
                    Container(
                      //鳳梨本體AppIcon
                      width: PineRadius - 10,
                      height: PineRadius - 10,
                      decoration: chatBoxAppIconDesign[2],
                    ),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Food: ${document['name']}',
                          style: chatBoxTextStyle,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Introduction: ${document["introduction"]}',
                          style: chatBoxTextStyle,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            // Fluttertoast.showToast(msg: "Pressed! in Chart.dart!");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatProviderPick(
                  foodName:document['name'],
                  post_id: document.id,
                ),
              ),
            );
          },
          style: chatBoxDesign,
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}