import 'package:flutter/material.dart';
import 'package:food_bank_auth/models/user.dart';
import 'package:food_bank_auth/screens/authenticate/authenticate.dart';
import 'package:food_bank_auth/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<Users>(context);

    // return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home(user);
    }
  }
}
