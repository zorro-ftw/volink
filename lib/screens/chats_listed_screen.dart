import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/viewmodels/chats_list.dart';

class ChatsListedScreen extends StatefulWidget {
  @override
  _ChatsListedScreenState createState() => _ChatsListedScreenState();
}

class _ChatsListedScreenState extends State<ChatsListedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonBackgroundColor,
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.white54),
        ),
      ),
      body: ChatsList(),
    );
  }
}
