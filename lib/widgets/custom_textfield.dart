import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.prefixIcon,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.hintText,
      this.inputTextStyle,
      this.keyboardType,
      this.textFieldController,
      this.onChanged});

  final Icon prefixIcon;
  final Color focusedBorderColor, enabledBorderColor;
  final String hintText;
  final TextStyle inputTextStyle;
  final TextInputType keyboardType;
  final TextEditingController textFieldController;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    final kTextFieldDecoration = InputDecoration(
      hintText: 'Enter a value',
      hintStyle: inputTextStyle,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

    return Theme(
      data: Theme.of(context).copyWith(primaryColor: focusedBorderColor),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: TextField(
          controller: textFieldController,
          keyboardType: keyboardType,
          style: inputTextStyle,
          textAlign: TextAlign.center,
          obscureText: true,
          onChanged: onChanged,
          decoration: kTextFieldDecoration.copyWith(
              hintText: hintText, prefixIcon: prefixIcon),
        ),
      ),
    );
  }
}
