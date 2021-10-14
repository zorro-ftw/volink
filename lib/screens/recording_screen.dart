import 'package:flutter/material.dart';
import 'package:volink/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/audio_data.dart';

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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconButton(
                backGroundColor: Colors.white,
                elevation: 5,
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 45,
                ),
                onTap: () {
                  //TODO - Cancel recording çağırılacak
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 8,
              ),
              CustomIconButton(
                backGroundColor: Colors.white,
                elevation: 5,
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 45,
                ),
                onTap: () {
                  //TODO - Pause recording çağırılacak
                },
              ),
              SizedBox(
                width: 8,
              ),
              CustomIconButton(
                backGroundColor: Colors.white,
                elevation: 5,
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.done_rounded,
                  color: Colors.green,
                  size: 45,
                ),
                onTap: () {
                  //TODO - Stop recording & upload çağırılacak
                  Provider.of<AudioData>(context, listen: false).stopRecord();
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
