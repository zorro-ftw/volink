import 'package:flutter/foundation.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/models/message.dart';

class ChatsListData extends ChangeNotifier {
  List<Chat> _userChats = [
    Chat(
      chatID: "asd",
      peerID: "asd",
      peerName: "asdadffghhhgjgjh",
      peerPhotoURL:
          "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg",
      lastMessageAt: DateTime.now(),
      messages: [
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
      ],
    ),
    Chat(
      chatID: "asd",
      peerID: "asd",
      peerName: "asdadffghhhgjgjh",
      peerPhotoURL:
          "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg",
      lastMessageAt: DateTime.now(),
      messages: [
        Message(
            messageID: "asd1",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd2",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd3",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd4",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
      ],
    ),
    Chat(
      chatID: "asd",
      peerID: "asd",
      peerName: "asdadffghhhgjgjh",
      peerPhotoURL:
          "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg",
      lastMessageAt: DateTime.now(),
      messages: [
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
      ],
    ),
    Chat(
      chatID: "asd",
      peerID: "asd",
      peerName: "asdadffghhhgjgjh",
      peerPhotoURL:
          "https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg",
      lastMessageAt: DateTime.now(),
      messages: [
        Message(
            messageID: "asd",
            sentAt: DateTime.now(),
            receiverID: "asd",
            receiverName: "asd",
            senderID: "asd",
            senderName: "asd"),
      ],
    ),
  ];
  get userChatsCount {
    return _userChats.length;
  }

  get userChats {
    return _userChats;
  }
}
