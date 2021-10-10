class Message {
  Message(
      {this.messageID,
      this.sentAt,
      this.receiverID,
      this.receiverName,
      this.senderID,
      this.senderName});

  final String messageID;
  final DateTime sentAt;
  final String senderID;
  final String senderName;
  final String receiverID;
  final String receiverName;
}
