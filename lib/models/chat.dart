import 'package:volink/models/message.dart';
import 'package:flutter/material.dart';

class Chat {
  Chat(
      {this.chatID,
      this.peerID,
      this.messages,
      this.lastMessageAt,
      this.peerPhotoURL});
  final String chatID;
  final String peerID;
  final List<Message> messages;
  final DateTime lastMessageAt;
  final String peerPhotoURL;
}
