import 'package:volink/models/message.dart';
import 'package:flutter/material.dart';

class Chat {
  Chat({this.chatID, this.receiverID, this.messages, this.lastMessageAt});
  final String chatID;
  final String receiverID;
  final List<Message> messages;
  final DateTime lastMessageAt;
}
