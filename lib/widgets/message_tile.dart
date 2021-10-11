import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/models/message.dart';

class MessageTile extends StatelessWidget {
  MessageTile({this.message, this.ownMessage});
  final Message message;
  final bool ownMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: ownMessage
                ? kOwnMessageTileDecoration
                : kPeerMessageTileDecoration,
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: kPlayButtonColor,
                  size: 40,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(message.messageID)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//Color(0xFF3730A3).withOpacity(1),
