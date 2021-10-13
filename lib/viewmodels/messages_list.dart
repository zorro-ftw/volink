import 'package:flutter/material.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chat_main_data.dart';
import 'package:volink/widgets/message_tile.dart';
import 'package:provider/provider.dart';

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
}
