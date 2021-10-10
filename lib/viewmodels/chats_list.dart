import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chats_list_data.dart';
import 'package:volink/widgets/chat_tile.dart';
import 'package:volink/models/chat.dart';

class ChatsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsListData>(builder: (context, chatsListData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ChatTile(chat: chatsListData.userChats[index]);
        },
        itemCount: chatsListData.userChatsCount,
      );
    });
  }
}
