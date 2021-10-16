class Chat {
  Chat(
      {this.chatID,
      this.peerID,
      this.peerName,
      this.messages,
      this.lastMessageAt,
      this.peerPhotoURL});
  final String chatID;
  final String peerID;
  final String peerName;
  final List messages;
  final DateTime lastMessageAt;
  final String peerPhotoURL;
}
