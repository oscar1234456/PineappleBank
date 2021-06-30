import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/chatRoom/chatRoom.dart';
import 'package:food_bank_auth/services/dataprocess.dart';
import 'package:food_bank_auth/util/loading.dart';
import 'package:food_bank_auth/util/styleDesign.dart';

class ChatProviderPick extends StatefulWidget {
  const ChatProviderPick({Key key, @required this.post_id, @required this.foodName}) : super(key: key);
  final post_id;
  final foodName;
  @override
  _ChatProviderPickState createState() =>
      _ChatProviderPickState();
}

class _ChatProviderPickState extends State<ChatProviderPick> {
  _ChatProviderPickState({Key key});


  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  Future getAllReceiverIdInFood;
  final ScrollController listScrollController = ScrollController();
  final _auth = FirebaseAuth.instance;
  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;

  // List<Choice> choices = <Choice>[
  //   Choice(title: "Settings", icon: Icons.settings),
  //   Choice(title: "Log out", icon: Icons.exit_to_app)
  // ];

  // void handleClick(Choice choice) {
  //   switch (choice.title) {
  //     case 'Log out':
  //     //Push Log out
  //       Fluttertoast.showToast(msg: "log out");
  //       handleSignOut();
  //       break;
  //     case 'Settings':
  //     //Push Settings
  //       Fluttertoast.showToast(msg: "Settings");
  //       break;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    DataFetch s = DataFetch();
    s.fetchAllReceiverIdInFood(widget.post_id);
    getAllReceiverIdInFood = getAllReceiverIdInFoodFunc();
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
  Future<List<dynamic>> getAllReceiverIdInFoodFunc() async{
    var PostidArray;
    DataFetch s = DataFetch();
    PostidArray = await s.fetchAllReceiverIdInFood(widget.post_id);
    print(PostidArray);
    return PostidArray;
  }

  @override
  Widget build(BuildContext context) {
    final WindowW = MediaQuery.of(context).size.width;
    final WindowH = MediaQuery.of(context).size.height;
    final UserRadius = WindowW / 4;
    return Scaffold(
      appBar: AppBar(
        title:Text("${widget.foodName}"),
        elevation: 0.0,
      ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            // List
            Container(
              child:FutureBuilder(
                future: getAllReceiverIdInFood,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    print("You are in builder(getAllReceiver): ${snapshot.data}");
                    if (snapshot.data.length == 0){
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          "None of users saved it!",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: double.infinity),
                        //color: Colors.deepOrangeAccent.withOpacity(0.8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      );
                    }else{
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          return buildItem(context, snapshot.data[index], UserRadius,widget.foodName);
                        },
                        itemCount: snapshot.data.length,
                        controller: listScrollController,
                      );
                    }

                    return Container(child:Text("444"));
                  }else{
                    return Loading();
                  }
                }
              ),
            ),
            // Loading
            Positioned(
              child: isLoading ? Loading() : Container(),
            )
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document, UserRadius, foodName) {

    print("I am buildItem");
    print("my document[id]: ${document['displayName']}");
    if (document['displayName'] == _auth.currentUser.uid) {
      return Container();
    } else {
      return Container(
        child: TextButton(
          child: Row(
            children: <Widget>[
              // Material(
              //   child: chatBoxIcon,
              //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
              //   clipBehavior: Clip.hardEdge,
              // ),
              Container(
                width: UserRadius - 50,
                height: UserRadius - 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    // image: AssetImage(UserAImgPath),//For test
                    image: NetworkImage(document['photo']),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${document['displayName']}',
                          style:  chatBoxTextStyleUser,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      // Container(
                      //   child: Text(
                      //     'About me: ${document["provider"]}',
                      //     style: chatBoxTextStyle,
                      //   ),
                      //   alignment: Alignment.centerLeft,
                      //   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      // )
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
                    builder: (context) => ChatRoom(
                      post_id: widget.post_id,
                      peer_id: document["user_id"],
                      isProvider: true,
                      foodName: foodName
                    )));
          },
          style: chatBoxDesign,
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}

