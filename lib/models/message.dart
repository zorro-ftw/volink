import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message(
      {this.messageID,
      this.messageForID,
      this.sentAt,
      this.voiceFileURL,
      this.receiverID,
      this.receiverName,
      this.senderID,
      this.senderName});

  final String messageID;
  final Timestamp sentAt;
  final String senderID;
  final String senderName;
  final String receiverID;
  final String receiverName;
  final String voiceFileURL;
  final String messageForID;
}
