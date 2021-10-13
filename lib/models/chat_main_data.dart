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
    await for (var snapshot
        in firestore.collection('chats').doc(currentChat.chatID).snapshots()) {
      updateCurrentChatMessages(snapshot);
    }
  }

  void updateCurrentChatMessages(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    List<String> snapshotMessages = snapshot.data()['messages'];
    if (snapshotMessages.isNotEmpty) {
      for (int i = 0; i < snapshotMessages.length; i++) {
        Map<String, dynamic> currentMessageRaw = await DataService()
            .getCollectionByIdQuery(
                documentID: snapshotMessages[i], collection: 'messages');
        Message currentMesage = Message(
          messageID: snapshotMessages[i],
          sentAt: currentMessageRaw['sentAt'],
          voiceFileURL: currentMessageRaw['voiceFileURL'],
          receiverID: currentMessageRaw['receiverID'],
          receiverName: currentMessageRaw['receiverName'],
          senderID: currentMessageRaw['senderID'],
          senderName: currentMessageRaw['senderName'],
        );
        if (currentChatMessages.length == 0) {
          currentChatMessages.add(currentMesage);
        } else if (currentChatMessages.length <= snapshotMessages.length) {
          bool isNew = true;
          for (int j = 0; j < currentChatMessages.length; j++) {
            if (currentChatMessages[j].messageID == currentMesage.messageID) {
              isNew = false;
              currentChatMessages[j] = currentMesage;
            }
          }
          if (isNew) {
            currentChatMessages.add(currentMesage);
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
