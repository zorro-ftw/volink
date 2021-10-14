import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/constants.dart';

class CustomAvatar extends StatelessWidget {
  CustomAvatar({this.chat, this.radius});
  final Chat chat;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      chat.peerPhotoURL == null
          ? ''
          : chat
              .peerPhotoURL, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
      radius: radius == null ? 25 : radius, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 1, // sets border, default 0.0
      initialsText: Text(
        chat.peerName.characters.first,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ), // sets initials text, set your own style, default Text('')
      borderColor: kGeneralColor, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      foregroundColor: Colors.brown.withOpacity(
          0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      imageFit: BoxFit.cover,
    );
  }
}
