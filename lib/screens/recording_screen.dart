import 'package:flutter/material.dart';
import 'package:volink/firebase_services/data_service.dart';
import 'package:volink/models/chat_main_data.dart';
import 'package:volink/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/audio_data.dart';
import 'package:volink/models/chats_list_data.dart';

class RecordingScreen extends StatelessWidget {
  final FileService fileService = FileService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  Provider.of<AudioData>(context, listen: false).cancelRecord(
                      Provider.of<AudioData>(context, listen: false)
                          .recordFilePath);
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
                onTap: () async {
                  //TODO - Stop recording & upload çağırılacak
                  bool s = await Provider.of<AudioData>(context, listen: false)
                      .stopRecord();
                  if (s) {
                    await fileService.uploadAudio(
                        displayedChat:
                            Provider.of<ChatMainData>(context, listen: false)
                                .displayedChat,
                        userChats:
                            Provider.of<ChatsListData>(context, listen: false)
                                .userChats,
                        recordFilePath:
                            Provider.of<AudioData>(context, listen: false)
                                .recordFilePath);
                  }
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
