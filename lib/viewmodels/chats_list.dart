import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chats_list_data.dart';
import 'package:volink/screens/chat_main_screen.dart';
import 'package:volink/widgets/chat_tile.dart';
import 'package:volink/models/chat_main_data.dart';

class ChatsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsListData>(builder: (context, chatsListData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ChatTile(
            chat: chatsListData.userChats[index],
            onTap: () {
              Provider.of<ChatMainData>(context, listen: false)
                  .getCurrentChatMessages(chatsListData.userChats[index]);

              pushNewScreen(
                context,
                screen: ChatMainScreen(
                  chat: chatsListData.userChats[index],
                ),
                withNavBar: false,
              );
            },
          );
        },
        itemCount: chatsListData.userChatsCount,
      );
    });
  }
}
