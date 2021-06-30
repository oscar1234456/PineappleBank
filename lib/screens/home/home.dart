

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_bank_auth/screens/home/PostEditPage.dart';
import 'package:food_bank_auth/screens/home/PostEditPage_Event.dart';
import 'package:food_bank_auth/screens/home/ProfilePage.dart';
import 'package:food_bank_auth/models/user.dart';
import 'package:food_bank_auth/screens/home/foodFindEventPage.dart';
import 'package:food_bank_auth/screens/home/foodFindFoodPage.dart';
import 'package:food_bank_auth/screens/home/foodFocusPage.dart';
import 'package:food_bank_auth/screens/home/placePage.dart';
import 'package:food_bank_auth/util/customIcon.dart';

class Home extends StatefulWidget {
  Users user;
  Home(Users user):user = user;

  @override
  _HomeState createState() => _HomeState(user);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;           //   小房子、 披薩、  活動、  map、 Profile
  final List<Widget> _children = [foodFocusPage(),foodFindFoodPage(),foodFindEventPage(), placePage(), ProfilePage()];
  //final AuthService _auth = AuthService();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Users user;
  _HomeState(user): user = user;

  @override
  void initState() {
    super.initState();
    registerNotification(); //Android need not to register
    configLocalNotification();
  }
  void registerNotification() {

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //   print("message: ${message.sentTime}");
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification!.body}');
    //     showNotification(message);
    //   }
    // });
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.Uid)
          .update({'pushToken': token});
    }).catchError((err) {
      Fluttertoast.showToast(msg: err.message.toString());
    });
  }



  void configLocalNotification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.example.chatroom.chatroom',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    // print("show notification id: ${message.messageId}");
    print(message['body'].toString());
    // await flutterLocalNotificationsPlugin.show(0, message.notification.title.toString(),
    //     message.notification.body.toString(), platformChannelSpecifics,payload:"123"
    // );
    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 24.0,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(customIcon.pizza, size: 24,),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, size: 30,),
            label: "Event",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place, size:30),
            label: "Places",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size:30),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
