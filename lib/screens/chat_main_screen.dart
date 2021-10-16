import 'package:flutter/material.dart';
import 'package:volink/models/audio_data.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/constants.dart';
import 'package:volink/screens/recording_screen.dart';
import 'package:volink/viewmodels/messages_list.dart';
import 'package:volink/widgets/custom_avatar.dart';
import 'package:volink/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class ChatMainScreen extends StatefulWidget {
  ChatMainScreen({this.chat});
  final Chat chat;
  @override
  _ChatMainScreenState createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  GlobalKey chatMainKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: chatMainKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomIconButton(
        backGroundColor: kButtonBackgroundColor,
        elevation: 5,
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.mic_outlined,
          color: kTextGradientColor1,
          size: 55,
        ),
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

          Provider.of<AudioData>(context, listen: false).recordVoice();
        },
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
              width: 10,
            ),
            Text(
              widget.chat.peerName,
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: MessagesList(),
      ),
      bottomNavigationBar: Container(
        height: 55,
        decoration: kChatMainScreenBottomDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomIconButton(
              backGroundColor: Colors.transparent,
              child: IconButton(
                  icon: Icon(
                    Icons.graphic_eq_rounded,
                    color: kTextGradientColor1,
                  ),
                  splashColor: kPlayButtonColor.withOpacity(0.3),
                  iconSize: 38,
                  onPressed: () {
                    //TODO - Ses filtre ekranı açılacak
                  }),
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
