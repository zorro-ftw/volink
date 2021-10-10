import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.title, this.color, @required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: MaterialButton(
        elevation: 1,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width * 0.75,
        height: 42.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

// color: color,
// borderRadius: BorderRadius.circular(30.0),
