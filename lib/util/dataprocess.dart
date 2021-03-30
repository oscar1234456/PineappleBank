import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/event.dart';
import 'package:food_bank_auth/models/food.dart';
import 'package:food_bank_auth/models/post.dart';

class DataUpload {
  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference foodcollection =
      FirebaseFirestore.instance.collection('food');
  final CollectionReference eventcollection =
      FirebaseFirestore.instance.collection('event');
  final CollectionReference postcollection =
      FirebaseFirestore.instance.collection('post');

  FirebaseAuth _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instanceFor(
          bucket: 'gs://foodbank-auth.appspot.com');

  firebase_storage.UploadTask _uploadTask;

  Future<void> uploadPost(
      File file,
      String title,
      String article,
      DateTime expiredate,
      double longitude,
      double latitude,
      List foodtype,
      String city,
      String district,) async {
    String filepath = 'food_image/${DateTime.now()}.png';
    await firebase_storage.FirebaseStorage.instance.ref(filepath).putFile(file);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();

    Map<String, dynamic> fooddata = {
      'city':city,
      'district':district,
      "photo": downloadURL,
      "name": title,
      "introduction": article,
      "best_before_time": expiredate,
      "food_type": foodtype,
    };

    foodcollection.add(fooddata);
    Map<String, dynamic> postdata = {
      "already_pick": false,
      "belonging_people_user_id": _auth.currentUser.uid,
      "publish": true,
      "picking_position": GeoPoint(latitude, longitude)
    };
    postcollection.add(postdata);
    // usercollection.doc(_auth.currentUser.uid).update({'publish_posts': id});
  }

  Future<void> uploadEvent(
      File file,
      String title,
      String article,
      DateTime startdate,
      DateTime enddate,
      double longitude,
      double latitude,
      String city,
      String district,
      List eventtype) async {
    String filepath = 'event_image/${DateTime.now()}.png';
    await firebase_storage.FirebaseStorage.instance.ref(filepath).putFile(file);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();

    Map<String, dynamic> eventdata = {
      "city": city,
      "district": district,
      "photo": downloadURL,
      "name": title,
      "introduction": article,
      "holding_date": startdate,
      "end_date": enddate,
      "event_type": eventtype,
      "picking_position": GeoPoint(latitude, longitude),
      "holding_people_user_id": _auth.currentUser.uid
    };
    eventcollection.add(eventdata);
    // usercollection.doc(_auth.currentUser.uid).update({'holding_event': id});
  }
}

class DataFetch {
  // Future<dynamic> fetchData(collection,id) async{
  //   dynamic s;
  //   await collection
  //       .doc(id)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) async{
  //     if(documentSnapshot.exists){
  //       print('Document exists on the database');
  //       s = documentSnapshot.data();
  //     }else{
  //       print("Fetching Error");
  //       return Text("No data in Firestore !");
  //     }
  //   });
  //   return s;
  // }
  Future<dynamic> fetchPostdata() async {
    var tempList = [];
    var i = 0;
    await FirebaseFirestore.instance
        .collection('food')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                var foodobj = Food();
                foodobj.best_before_time = doc['best_before_time'];
                foodobj.name = doc['name'];
                foodobj.introduction = doc['introduction'];
                foodobj.food_type = doc['food_type'];
                foodobj.photo = doc['photo'];
                foodobj.city = doc['city'];
                foodobj.district = doc['district'];
                tempList.add(foodobj);
              })
            });

    // await FirebaseFirestore.instance
    //     .collection('post')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) => {
    //           querySnapshot.docs.forEach((doc) {
    //             var postobj = Post();
    //             postobj.belong_people = doc['belonging_people_user_id'];
    //             postobj.position = doc['picking_position'];
    //             postobj.already_pick = doc['already_pick'];
    //             tempList.add(postobj);
    //           })
    //         });
    return tempList;
  }

  Future<dynamic> fetchEventdata() async {
    var tempList = [];
    await FirebaseFirestore.instance
        .collection('event')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                var eventobj = Event();
                eventobj.belonging_people = doc['holding_people_user_id'];
                eventobj.name = doc['name'];
                eventobj.introduction = doc['introduction'];
                eventobj.event_type = doc['event_type'];
                eventobj.startdate = doc['holding_date'];
                eventobj.enddate = doc['end_date'];
                eventobj.position = doc['picking_position'];
                eventobj.photo = doc['photo'];
                eventobj.city = doc['city'];
                eventobj.district = doc['district'];
                tempList.add(eventobj);
              })
            });
    return tempList;
  }
}
