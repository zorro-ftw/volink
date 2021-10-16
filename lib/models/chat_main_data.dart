import 'package:flutter/foundation.dart';
import 'package:volink/firebase_services/data_service.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMainData extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Message> currentChatMessages = [];
  Chat displayedChat;
  Future getCurrentChatMessages(Chat currentChat) async {
    displayedChat = currentChat;
    notifyListeners();
    await for (var snapshot
        in firestore.collection('chats').doc(currentChat.chatID).snapshots()) {
      updateCurrentChatMessages(snapshot);
    }
  }

  void updateCurrentChatMessages(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    List snapshotMessages = snapshot.data()['messages'];
    if (snapshotMessages.isNotEmpty) {
      for (int i = 0; i < snapshotMessages.length; i++) {
        Map<String, dynamic> currentMessageRaw = await DataService()
            .getCollectionByIdQuery(
                documentID: snapshotMessages[i].toString(),
                collection: 'messages');
        Message currentMessage = Message(
          messageID: snapshotMessages[i].toString(),
          messageForID: currentMessageRaw['messageForID'],
          sentAt: currentMessageRaw['sentAt'],
          voiceFileURL: currentMessageRaw['voiceFileURL'],
          receiverID: currentMessageRaw['receiverID'],
          receiverName: currentMessageRaw['receiverName'],
          senderID: currentMessageRaw['senderID'],
          senderName: currentMessageRaw['senderName'],
        );
        if (currentChatMessages.length == 0) {
          currentChatMessages.add(currentMessage);
        } else if (currentChatMessages.length <= snapshotMessages.length) {
          bool isNew = true;
          for (int j = 0; j < currentChatMessages.length; j++) {
            if (currentChatMessages[j].messageID == currentMessage.messageID) {
              isNew = false;
              currentChatMessages[j] = currentMessage;
            }
          }
          if (isNew) {
            currentChatMessages.insert(0, currentMessage);
          }
        }
      }

      if (currentChatMessages.length > snapshotMessages.length) {
        for (int k = 0; k < currentChatMessages.length; k++) {
          if (!snapshotMessages.contains(currentChatMessages[k])) {
            currentChatMessages.removeAt(k);
          }
        }
      }
    } else {
      currentChatMessages.clear();
    }
    notifyListeners();
  }
}
