import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/user.dart';
import 'package:food_bank_auth/screens/wrapper.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //full screen
    SystemChrome.setEnabledSystemUIOverlays([]);
    return StreamProvider<Users>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent[200],
          accentColor: Colors.orangeAccent[100],
        ),
        debugShowCheckedModeBanner: false, //去除Debug標誌
        home: Wrapper(),
      ),
    );
  }
}

