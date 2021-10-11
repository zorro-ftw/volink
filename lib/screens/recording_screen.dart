import 'package:flutter/material.dart';
import 'package:volink/constants.dart';

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Recording",
            style: TextStyle(color: Colors.green, fontSize: 26),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            elevation: 5,
            color: Colors.white,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.done_rounded,
                color: Colors.green,
                size: 45,
              ),
            ),
          )
        ],
      ),
    );
  }
}
