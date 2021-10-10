import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/models/chat.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:intl/intl.dart';

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
        leading: CircularProfileAvatar(
          'https://toraks.org.tr/site/sf/nmf/pre_migration/cba88935e820a8d166759cda95c39f2de21a69518010c9b54355f4c3faaf86cc.jpg', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
          radius: 30, // sets radius, default 50.0
          backgroundColor:
              Colors.transparent, // sets background color, default Colors.white
          borderWidth: 1, // sets border, default 0.0
          initialsText: Text(
            "AD",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ), // sets initials text, set your own style, default Text('')
          borderColor: kGeneralColor, // sets border color, default Colors.white
          elevation:
              5.0, // sets elevation (shadow of the profile picture), default value is 0.0
          foregroundColor: Colors.brown.withOpacity(
              0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
          cacheImage: true, // allow widget to cache image against provided url
          imageFit: BoxFit.cover,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            chat.peerID,
            style: TextStyle(color: kGeneralColor),
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
      style: TextStyle(color: kGeneralColor),
    );
  }
}
