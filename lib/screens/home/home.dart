import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/home/ProfilePage.dart';
import 'package:food_bank_auth/models/user.dart';
import 'package:food_bank_auth/screens/home/mainPage.dart';
import 'package:food_bank_auth/screens/home/placePage.dart';
import 'package:food_bank_auth/services/auth.dart';
import 'package:food_bank_auth/util/customIcon.dart';

class Home extends StatefulWidget {
  Users user;
  Home(Users user):user = user;

  @override
  _HomeState createState() => _HomeState(user);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [mainPage(), placePage(), ProfilePage()];
  final AuthService _auth = AuthService();
  Users user;
  _HomeState(user): user = user;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      //TODO: Change Logout to profile drawer
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.0,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(customIcon.pizza),
            label: "Food",
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
