import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/audio_manager.dart';
import 'package:volink/models/chat_main_data.dart';
import 'package:volink/widgets/message_tile.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/message.dart';

class MessagesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatMainData>(builder: (context, chatMainData, child) {
      return chatMainData.currentChatMessages.length == 0
          ? Center(
              child: Text(
                "Send a message and start conversation!",
                style: TextStyle(color: Colors.white54, fontSize: 17),
              ),
            )
          : ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return MessageTile(
                  audioManager: AudioManager(
                      messageURL:
                          chatMainData.currentChatMessages[index].voiceFileURL),
                  message: chatMainData.currentChatMessages[index],
                  ownMessage:
                      chatMainData.currentChatMessages[index].senderID ==
                              AuthService().currentUserId
                          ? true
                          : false,
                );
              },
              itemCount: chatMainData.currentChatMessages.length);
    });
  }

  Widget getDayDifference(
      {List<Message> messages, int index, ChatMainData chatMainData}) {
    if (index != messages.length - 1) {
      if (messages[index].sentAt.toDate().day !=
          messages[index + 1].sentAt.toDate().day) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ],
        );
      } else {
        return MessageTile(
          audioManager: AudioManager(
              messageURL: chatMainData.currentChatMessages[index].voiceFileURL),
          message: chatMainData.currentChatMessages[index],
          ownMessage: chatMainData.currentChatMessages[index].senderID ==
                  AuthService().currentUserId
              ? true
              : false,
        );
      }
    } else {
      return MessageTile(
        audioManager: AudioManager(
            messageURL: chatMainData.currentChatMessages[index].voiceFileURL),
        message: chatMainData.currentChatMessages[index],
        ownMessage: chatMainData.currentChatMessages[index].senderID ==
                AuthService().currentUserId
            ? true
            : false,
      );
    }
  }
}
