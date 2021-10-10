import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/viewmodels/chats_list.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chats_list_data.dart';

class ChatsListedScreen extends StatefulWidget {
  @override
  _ChatsListedScreenState createState() => _ChatsListedScreenState();
}

class _ChatsListedScreenState extends State<ChatsListedScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ChatsListData>(context).userChatsCount == 0
        ? Scaffold(
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
            body: Center(
              child: Text(
                "You have no chat history.",
                style: TextStyle(color: kGeneralColor, fontSize: 18),
              ),
            ),
          )
        : Scaffold(
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
            body: Container(
                padding: EdgeInsets.only(bottom: 10), child: ChatsList()),
          );
  }
}
