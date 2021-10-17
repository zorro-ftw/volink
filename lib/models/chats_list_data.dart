import 'package:flutter/foundation.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:volink/models/notification_manager.dart';

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

  String checkPhotoURL(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data()['peerPhotoURLs'].length != 0) {
      if (snapshot.data()['peerPhotoURLs'][0] ==
          AuthService().currentUser().photoURL) {
        return snapshot.data()['peerPhotoURLs'][1];
      } else {
        return snapshot.data()['peerPhotoURLs'][0];
      }
    } else {
      return null;
    }
  }

  void updateUserChatList(QuerySnapshot<Map<String, dynamic>> snapshot) async {
    List<Chat> onlineChatList = [];
    print("SNAPSHOT DOCS = ${snapshot.docs}");

    if (snapshot.docs.isNotEmpty) {
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
          peerPhotoURL: checkPhotoURL(snapshot.docs[i]),
        );
        onlineChatList.add(currentChat);
        if (_userChats.length == 0) {
          _userChats.add(currentChat);
          await NotificationManager().showNotification(
              title: '1 new message',
              body: 'New message from ${currentChat.peerName}');
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
            //TODO - Bildirim gönderilecek
            await NotificationManager().showNotification(
                title: '1 new message',
                body: 'New message from ${currentChat.peerName}');
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
