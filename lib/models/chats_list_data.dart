import 'package:flutter/foundation.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsListData extends ChangeNotifier {
  List<Chat> _userChats = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  get userChatsCount {
    return _userChats.length;
  }

  List<Chat> get userChats {
    return _userChats;
  }

  Future getUserChatList() async {
    await for (var snapshot in firestore
        .collection('chats')
        .where('peerIDs', arrayContains: AuthService().currentUserId)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()) {
      updateUserChatList(snapshot);
    }
  }

  void updateUserChatList(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Chat> onlineChatList = [];

    if (snapshot.size != 0) {
      print("if'in içine girdi");
      for (int i = 0; i < snapshot.docs.length; i++) {
        Chat currentChat = Chat(
            chatID: snapshot.docs[i].id,
            peerID: snapshot.docs[i].data()['peerIDs'][0] ==
                    AuthService().currentUserId
                ? snapshot.docs[i].data()['peerIDs'][1]
                : snapshot.docs[i].data()['peerIDs'][0],
            peerName: snapshot.docs[i].data()['peerNames'][0] ==
                    AuthService().currentUser().displayName
                ? snapshot.docs[i].data()['peerNames'][1]
                : snapshot.docs[i].data()['peerNames'][0],
            messages: snapshot.docs[i].data()['messages'],
            lastMessageAt: snapshot.docs[i].data()['lastMessageAt'].toDate(),
            peerPhotoURL: snapshot.docs[i].data()['photoURLs'][0] ==
                    AuthService().currentUser().photoURL
                ? snapshot.docs[i].data()['photoURLs'][1]
                : snapshot.docs[i].data()['photoURLs'][0]);
        onlineChatList.add(currentChat);
        if (_userChats.length == 0) {
          _userChats.add(currentChat);
        } else if (_userChats.length < snapshot.size) {
          bool isNew = true;
          for (int j = 0; j < _userChats.length; j++) {
            if (_userChats[j].chatID == currentChat.chatID) {
              isNew = false;
              _userChats[j] = currentChat;
            }
          }
          if (isNew) {
            _userChats.add(currentChat);
          }
        }
      }
      if (_userChats.length > snapshot.size) {
        for (int k = 0; k < _userChats.length; k++) {
          if (!onlineChatList.contains(_userChats[k])) {
            _userChats.removeAt(k);
          }
        }
      }
    } else {
      print("updateUserChatList chat olmadığı için else'in içine girdi.");
      _userChats.clear();
    }
    notifyListeners();
  }
}
