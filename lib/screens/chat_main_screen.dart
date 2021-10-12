import 'package:flutter/material.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/constants.dart';
import 'package:volink/screens/recording_screen.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return RecordingScreen();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              backgroundColor: kBackgroundColor);
        },
        child: Material(
          elevation: 5,
          color: kButtonBackgroundColor,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.mic_outlined,
              color: kTextGradientColor1,
              size: 55,
            ),
          ),
        ),
      ),
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
        padding: EdgeInsets.only(bottom: 5),
        child: MessagesList(
          chat: widget.chat,
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        decoration: kChatMainScreenBottomDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: IconButton(
                  icon: Icon(
                    Icons.graphic_eq_rounded,
                    color: kTextGradientColor1,
                  ),
                  splashColor: kPlayButtonColor.withOpacity(0.3),
                  iconSize: 40,
                  onPressed: () {}),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
