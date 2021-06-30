import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_bank_auth/models/event.dart';
import 'package:food_bank_auth/models/food.dart';

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

  Future<void> registerAccount(String displayName, String email,
      String photoURL, String provider) async {
    Map<String, dynamic> userdata = {
      "displayName": displayName,
      "email": email,
      "photo": photoURL,
      "provider": provider,
      "user_id": _auth.currentUser.uid,
      "save_posts":[],
    };
    usercollection.doc(_auth.currentUser.uid).set(userdata);
  }

  Future<void> uploadPost(
    File file,
    String title,
    String article,
    DateTime expiredate,
    double longitude,
    double latitude,
    List foodtype,
    String city,
    String district,
  ) async {
    foodcollection
        .where("name", isEqualTo: title) //檢查food title 是否唯一
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print("title is not unique!");
        //TODO return alertdialog
        //TODO stop uploading food & post
      }
    });

    String filepath = 'food_image/${DateTime.now()}.png';
    await firebase_storage.FirebaseStorage.instance.ref(filepath).putFile(file);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(filepath)
        .getDownloadURL();

    Map<String, dynamic> fooddata = {
      "photo": downloadURL,
      "name": title,
      "introduction": article,
      "best_before_time": expiredate,
      "food_type": foodtype,
    };

    await foodcollection
        .add(fooddata)
        .then((docRef) => usercollection.doc(_auth.currentUser.uid).update({
              'publish_posts': FieldValue.arrayUnion([docRef.id])
            }));

    Map<String, dynamic> postdata = {
      'city': city,
      'district': district,
      "already_pick": false,
      "belonging_people_user_id": _auth.currentUser.uid,
      "publish": true,
      "picking_position": GeoPoint(latitude, longitude)
    };

    usercollection
        .doc(_auth.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      int length = documentSnapshot.data()['publish_posts'].length;
      postcollection
          .doc(documentSnapshot.data()['publish_posts'][length - 1])
          .set(postdata);
    });
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
    eventcollection.add(eventdata).then((docRef) => //將event_id寫入創建的user底下
        usercollection.doc(_auth.currentUser.uid).update({
          'holding_events': FieldValue.arrayUnion([docRef.id])
        }));
  }
}

class DataFetch {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> fetchPostdata() async {
    var tempList = [];
    await FirebaseFirestore.instance
        .collection('food')
        .get()
        .then((QuerySnapshot querySnapshot) async{
              // querySnapshot.docs.forEach((doc) {
              //   var foodobj = Food();
              //   foodobj.best_before_time = doc['best_before_time'];
              //   foodobj.name = doc['name'];
              //   foodobj.introduction = doc['introduction'];
              //   foodobj.food_type = doc['food_type'];
              //   foodobj.photo = doc['photo'];
              //   foodobj.city = "doc['city']";
              //   foodobj.district = "doc['district']";
              //   foodobj.id = doc.id;
              //   tempList.add(foodobj);
              // });
              for(var doc in querySnapshot.docs){
                  final DocumentSnapshot result = await FirebaseFirestore.instance
                        .collection("post")
                        .doc(doc.id)
                        .get();

                  var foodobj = Food();
                  foodobj.best_before_time = doc['best_before_time'];
                  foodobj.name = doc['name'];
                  foodobj.introduction = doc['introduction'];
                  foodobj.food_type = doc['food_type'];
                  foodobj.photo = doc['photo'];
                  foodobj.city = result.data()["city"];
                  foodobj.district = result.data()["district"];
                  foodobj.id = doc.id;
                  tempList.add(foodobj);
              }
            });
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

  Future<List<dynamic>> fetchUserProvidedPostList() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('user')
        .where('user_id', isEqualTo: _auth.currentUser.uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents != null) {
      print('publish_post: ${documents[0].data()["publish_posts"][0]}');
      final String post_id = documents[0].data()["publish_posts"][0];
      // final DocumentSnapshot result = await FirebaseFirestore.instance
      //     .collection('food')
      //     .doc(post_id)
      //     .get();
      return documents[0].data()["publish_posts"];
      // print("NOOOOO! ${result.data()}");
    }
  }

  Future<Null> fetchTestData() async {
    final result = await FirebaseFirestore.instance.collection('test');
    final rr = await result.doc('1').collection('1').get();
    // final ids = await result.doc('1').collection('1');
    final List<DocumentSnapshot> documents = rr.docs;
    // final documents = rr.data();
    if (documents != null) {
      // print("name:${documents[0].data()["s"]}");
      print("name:${documents[0].id}");
      // print('name: ${documents[0].data()["name"][0]}');
      // final String name = documents[0].data()["name"][0];
      // final DocumentSnapshot result = await FirebaseFirestore.instance
      //     .collection('food')
      //     .doc(post_id)
      //     .get();
      // print("NOOOOO! ${result.data()}");
    } else {
      print("it;s null");
    }
  }

  Future<List<dynamic>> fetchUserPostList() async {
    List<DocumentSnapshot> tempList = [];
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('post')
        .where('belonging_people_user_id', isEqualTo: _auth.currentUser.uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents != null) {
      for (var element in documents) {
        final DocumentSnapshot result = await FirebaseFirestore.instance
            .collection('food')
            .doc("${element.id}")
            .get();
        print("for: ${result}");
        tempList.add(result);
      }
      print("tempList:${tempList}");
      tempList.forEach((element) {
        print("i am for eachy ${element.data()["introduction"]}");
      });
    }
    return tempList;
  }

  Future<List<dynamic>> fetchUserSavePostAndFood() async {
    List<DocumentSnapshot> tempList = [];
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('user')
        .doc(_auth.currentUser.uid)
        .get();
    // final List<DocumentSnapshot> documents = result.docs;
    if (result != null) {
      List<dynamic> save_posts = result.data()["save_posts"];
      for (var element in save_posts) {
        final DocumentSnapshot result = await FirebaseFirestore.instance
            .collection('food')
            .doc(element)
            .get();
        print("get Food Info.: ${result.data()["name"]}");
        tempList.add(result);
      }
      print("tempList:${tempList}");
      tempList.forEach((element) {
        print("Foood: ${element.data()["introduction"]}");
      });
    }
    return tempList;
  }

  Future<List<dynamic>> fetchAllReceiverIdInFood(String foodId) async {
    List<DocumentSnapshot> tempList = [];
    print("post_idd: ${foodId}");
    final result = await FirebaseFirestore.instance.collection('message');
    final rr = await result.doc(foodId).collection(foodId).get();
    // final ids = await result.doc('1').collection('1');
    final List<DocumentSnapshot> documents = rr.docs;
   
    for(var element in documents){
      final DocumentSnapshot result = await FirebaseFirestore.instance
          .collection("user")
          .doc(element.id)
          .get();
      print("FFFEach ${result.data()["displayName"]}");
      tempList.add(result);
    }
    return tempList;
    // final List<DocumentSnapshot> documents = result.docs;
    // print("result: ${result.data()}");
  }
}

class UpdateData {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Null> updateUserSavePost(String foodId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(_auth.currentUser.uid)
        .update({
      'save_posts': FieldValue.arrayUnion([foodId])
    });
  }
}

class SendMsg {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Null> sendMessage(
      String foodId, String idTo, String content, bool isProvider) async {
    final DocumentReference newMessage = await FirebaseFirestore.instance
        .collection("message")
        .doc(foodId)
        .collection(foodId)
        .doc(isProvider ? idTo : _auth.currentUser.uid)
        .collection(isProvider ? idTo : _auth.currentUser.uid)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        newMessage,
        {
          'idFrom': _auth.currentUser.uid,
          'idTo': idTo,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': content,
          'type': 0,
        },
      );
    });
    final DocumentReference needToAdd = await FirebaseFirestore.instance
        .collection("message")
        .doc(foodId)
        .collection(foodId)
        .doc(isProvider ? idTo : _auth.currentUser.uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        needToAdd,
        {
          'test':1,
        },
      );
    });
  }
}
