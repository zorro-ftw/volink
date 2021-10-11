import 'package:flutter/material.dart';
import 'package:volink/widgets/message_tile.dart';
import 'package:volink/models/chat.dart';

class MessagesList extends StatelessWidget {
  MessagesList({this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemBuilder: (context, index) {
          return MessageTile(
            message: chat.messages[index],
            ownMessage: index % 3 == 0 ? true : false,
          );
        },
        itemCount: chat.messages.length);
  }
}
