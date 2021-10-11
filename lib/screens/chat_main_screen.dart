import 'package:flutter/material.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/constants.dart';
import 'package:volink/viewmodels/messages_list.dart';
import 'package:volink/widgets/custom_avatar.dart';

class ChatMainScreen extends StatefulWidget {
  ChatMainScreen({this.chat});
  final Chat chat;
  @override
  _ChatMainScreenState createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAvatar(
              chat: widget.chat,
              radius: 18,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              widget.chat.peerName,
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
      body: Container(
        child: MessagesList(
          chat: widget.chat,
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: kChatMainScreenBottomDecoration,
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                  icon: Icon(Icons.graphic_eq_rounded),
                  splashColor: kPlayButtonColor,
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
