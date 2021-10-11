import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/models/chat.dart';
import 'package:intl/intl.dart';
import 'package:volink/widgets/custom_avatar.dart';

class ChatTile extends StatelessWidget {
  ChatTile({this.chat, this.onTap});

  final Chat chat;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 4),
      // color: Color(0xFF3730A3).withOpacity(0.6),
      child: ListTile(
        onTap: onTap,
        leading: CustomAvatar(
          chat: chat,
          radius: 24,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            chat.peerID,
            style: TextStyle(color: kGeneralColor, fontSize: 20),
          ),
        ),
        trailing: getLastMessageDateFormatted(),
      ),
    );
  }

  Text getLastMessageDateFormatted() {
    String formattedDate;
    var formatHm = DateFormat.Hm();
    var formatyMd = DateFormat.yMMMd();
    if (chat.lastMessageAt.day == DateTime.now().day) {
      formattedDate = formatHm.format(chat.lastMessageAt);
    } else if (chat.lastMessageAt.day ==
        DateTime.now().subtract(Duration(days: 1)).day) {
      formattedDate = "Yesterday";
    } else {
      formattedDate = formatyMd.format(chat.lastMessageAt);
    }

    return Text(
      formattedDate,
      style: TextStyle(color: kGeneralColor, fontSize: 16),
    );
  }
}
