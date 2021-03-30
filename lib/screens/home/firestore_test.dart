import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/services/database.dart';
import 'package:food_bank_auth/util/constants.dart';

class firestore_test extends StatefulWidget {
  @override
  _firestore_testState createState() => _firestore_testState();
}

class _firestore_testState extends State<firestore_test> {
  //input data
  String name = '';
  String statusword = '';
  String showUser="";

  FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: '姓名'),
              onChanged: (val) {
                setState(() => name = val);
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: '狀態消息'),
              onChanged: (val) {
                setState(() => statusword = val);
              },
            ),
            SizedBox(height: 30,),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent),
              ),
              color: Colors.green,
              height: 50,
              minWidth: 100,
              child: Text("Add Data"),
              onPressed: () async{
                // await DatabaseService().addData(_auth.currentUser.uid,name,statusword);
              }
            ),
            SizedBox(height: 30,),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent),
              ),
              color: Colors.orange,
              height: 50,
              minWidth: 100,
              child: Text("Fetch Data"),
              onPressed: () async {
                DatabaseService d = DatabaseService();
                Future<dynamic> dd;
                // dd = d.fetchData();
                dd.then((value){setState(() {
                  showUser = value.toString();
                });});

              },
            ),
            SizedBox(height: 30,),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent),
              ),
              color: Colors.brown,
              height: 50,
              minWidth: 100,
              child: Text("Update Data"),
              onPressed: () async{
                // await DatabaseService().updateData(_auth.currentUser.uid,name, statusword);
              },
            ),
            SizedBox(height: 30,),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent),
              ),
              color: Colors.redAccent,
              height: 50,
              minWidth: 100,
              child: Text("Delete Data"),
              onPressed: () async{
                // await DatabaseService().deleteData(_auth.currentUser.uid);
              },
            ),
            SizedBox(height: 30,),
            Text(
              showUser,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
