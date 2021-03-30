import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService{

  //collection reference
  final CollectionReference usercollection = FirebaseFirestore.instance.collection('user');


  // addData(String uid, String name,String statusword){
  //   Map<String,dynamic> demodata = {"name" : name,"status" : statusword};
  //   usercollection.doc(uid).set(demodata);
  // }

  Future<dynamic> fetchData(collection,id) async{
    dynamic s;
    await collection
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async{
              if(documentSnapshot.exists){
                print('Document exists on the database');
                s = documentSnapshot.data();
              }else{
                print("Fetching Error");
                return Text("No data in Firestore !");
              }
        });
    return s;
  }

  deleteData(collection,id) {
    collection.doc(id).delete();
  }

  // updateData(String uid,String name,String statusword){
  //   Map<String,dynamic> demodata = {"name" : name,"status" : statusword};
  //   usercollection.doc(uid).set(demodata);
  // }

}