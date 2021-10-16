import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/models/message.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  MessageTile({this.message, this.ownMessage});
  final Message message;
  final bool ownMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: ownMessage
                ? kOwnMessageTileDecoration
                : kPeerMessageTileDecoration,
            child: Row(
              children: [
                Material(
                  child: IconButton(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: kPlayButtonColor,
                    ),
                    onPressed: () {},
                    iconSize: 40,
                    padding: EdgeInsets.all(2),
                  ),
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                ),
                Container(
                  width: 85,
                  child: ProgressBar(
                      thumbRadius: 4,
                      thumbGlowRadius: 14,
                      timeLabelLocation: TimeLabelLocation.below,
                      timeLabelTextStyle:
                          TextStyle(color: kBackgroundColor, fontSize: 12),
                      progress: Duration(milliseconds: 1000),
                      total: Duration(milliseconds: 5000)),
                ),
                SizedBox(
                  width: 10,
                ),
                getMessageDateFormatted()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text getMessageDateFormatted() {
    String formattedDate;
    var formatHm = DateFormat.Hm();

    formattedDate = formatHm.format(message.sentAt.toDate());

    return Text(
      formattedDate,
      style: TextStyle(color: Colors.black, fontSize: 13),
    );
  }
}

//Color(0xFF3730A3).withOpacity(1),
