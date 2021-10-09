import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF303133);
const kTextGradientColor1 = Color(0xFF399E86);
const kTextGradientColor2 = Color(0xFFEF4321);
const kDivider = Divider(
  color: Color(0xFF1D1D1F),
  // color: Color(0xFFBDBDBD),
  height: 10,
  thickness: 2,
  indent: 20,
  endIndent: 20,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.white24),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF1D1D1F), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
