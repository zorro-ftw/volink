import 'package:flutter/material.dart';

const kDefaultProfilePhotoURL = '';

const kBackgroundColor = Color(0xFF303133);
const kTextGradientColor1 = Color(0xFF399E86);
const kTextGradientColor2 = Color(0xFFEF4321);
const kButtonBackgroundColor = Color(0xFF384152);
const kGeneralColor = Colors.white54;
const kPlayButtonColor = Color(0xFF47545A);

const kOwnMessageTileDecoration = BoxDecoration(
  color: kTextGradientColor1,
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const kPeerMessageTileDecoration = BoxDecoration(
  color: Color(0xFFCE654C),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const kChatMainScreenBottomDecoration = BoxDecoration(
  color: kButtonBackgroundColor,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
);

const kDivider = Divider(
  color: Color(0xFF1D1D1F),
  // color: Color(0xFFBDBDBD),
  height: 10,
  thickness: 2,
  indent: 20,
  endIndent: 20,
);
