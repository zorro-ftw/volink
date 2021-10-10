import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/enums.dart';

class MessageTile extends StatefulWidget {
  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<MessageTile> {
  PlayButtonState playButtonState = PlayButtonState.Paused;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: MaterialButton(
        onPressed: () {
          changeIcon();
        },
        child: playButtonState == PlayButtonState.Paused
            ? Icon(
                Icons.play_arrow,
                color: kGeneralColor,
              )
            : Icon(
                Icons.pause,
                color: kGeneralColor,
              ),
      ),
    );
  }

  void changeIcon() {
    setState(() {
      if (playButtonState == PlayButtonState.Paused) {
        playButtonState = PlayButtonState.Playing;
      } else {
        playButtonState = PlayButtonState.Paused;
      }
    });
  }
}
