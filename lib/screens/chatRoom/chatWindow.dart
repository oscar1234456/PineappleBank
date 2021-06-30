import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bank_auth/screens/chatRoom/chatReceiver.dart';
import 'chatProvider.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({Key key}) : super(key: key);
  @override
  _ChatWindowState createState() =>
      _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  _ChatWindowState({Key key});
  int _currentIndex = 0;
  final List<Widget> _children = [ChatProviderWindow(), ChatReceiverWindow()];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室 Chat Window'),
        elevation: 0.0,
      ),
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.0,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made, size:30),
            label: "Provide",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_received, size:30),
            label: "Receive",
          )
        ],
      ),
    );
  }
}

