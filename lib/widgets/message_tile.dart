import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/models/audio_manager.dart';
import 'package:volink/models/message.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:volink/enums.dart';

class MessageTile extends StatefulWidget {
  MessageTile({this.message, this.ownMessage, this.audioManager});
  final Message message;
  final bool ownMessage;
  final AudioManager audioManager;

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: widget.ownMessage
                ? kOwnMessageTileDecoration
                : kPeerMessageTileDecoration,
            child: Row(
              children: [
                Material(
                  child: getButton(),
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                ),
                Container(
                  width: 85,
                  child: getProgressBar(),
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: getMessageDateFormatted(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getProgressBar() {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: widget.audioManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progressBarColor: kPlayButtonColor,
          bufferedBarColor: kBufferingColor,
          baseBarColor: kBaseBarColor,
          thumbColor: kPlayButtonColor,
          thumbRadius: 5,
          thumbGlowRadius: 12,
          timeLabelLocation: TimeLabelLocation.below,
          timeLabelTextStyle: TextStyle(
              color: kPlayButtonColor,
              fontSize: 11,
              fontWeight: FontWeight.w600),
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
        );
      },
    );
  }

  Widget getButton() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: widget.audioManager.buttonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(11.5),
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPlayButtonColor),
              ),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow_rounded, color: kPlayButtonColor),
              iconSize: 40.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.audioManager.playMessage();
              },
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(
                Icons.pause_circle_outline_rounded,
                color: kPlayButtonColor,
              ),
              iconSize: 34.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.audioManager.pause();
              },
            );
          default:
            return Container();
        }
      },
    );
  }

  Text getMessageDateFormatted() {
    String formattedDate;
    var formatHm = DateFormat.Hm();

    formattedDate = formatHm.format(widget.message.sentAt.toDate());

    return Text(
      formattedDate,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 12,
      ),
    );
  }
}
