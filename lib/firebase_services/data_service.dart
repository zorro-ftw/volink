import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chat.dart';
import 'package:volink/models/message.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class DataService {
  Future getData(String collectionPath) async {
    final outputData = await firestore.collection(collectionPath).get();
    return outputData.docs;
  }

  Future addData({Map<String, dynamic> data, collectionPath}) async {
    try {
      await firestore
          .collection(collectionPath)
          .add(data)
          .whenComplete(() => null);
    } catch (e) {
      print(e.toString());
    }
  }

  Future getUserChatsQuery(
      {List queryArray,
      String collection,
      String field,
      String orderBy,
      bool descending}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, arrayContains: queryArray[0])
        .orderBy(orderBy, descending: descending)
        .get();
    if (queryOutputData.docs[0].data()[field].contains(queryArray[1])) {
      return queryOutputData.docs;
    } else {
      return null;
    }
  }

  Future getArrayQuery(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, arrayContainsAny: [queryString])
        .orderBy('createdAt', descending: false)
        .get();
    return queryOutputData.docs;
  }

  Future getArrayQueryUpdate(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, arrayContainsAny: [queryString]).get();
    return queryOutputData.docChanges;
  }

  Future getStringQuery(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, isEqualTo: queryString)
        .get();

    return queryOutputData.docs;
  }

  Future getStringIncludesQuery(
      {String queryString, String collection, String field}) async {
    final queryOutputData = await firestore
        .collection(collection)
        .where(field, isGreaterThanOrEqualTo: queryString)
        .get();

    return queryOutputData.docs;
  }

  Future<Map> getCollectionByIdQuery(
      {String documentID, String collection}) async {
    final queryOutputData =
        await firestore.collection(collection).doc(documentID).get();

    return queryOutputData.data();
  }

  Future<void> updateDataByID(
      {String collectionPath, String docID, String field, var value}) async {
    await firestore
        .collection(collectionPath)
        .doc(docID)
        .update({field: value});
    print('DATA GÜNCELLENDİ');
  }

  Future<void> deleteDataByID({String collectionPath, String docID}) async {
    await firestore.collection(collectionPath).doc(docID).delete();
    print("DATA SİLİNDİ");
  }
}

class FileService {
  Future handleChat(
      {List<Chat> userChats, Chat displayedChat, String voiceFileURL}) async {
    bool isNewChat = true;

    for (Chat chat in userChats) {
      if (chat.chatID == displayedChat.chatID) {
        isNewChat = false;
      }
    }
    if (!isNewChat) {
      var currentChatDummy = displayedChat;
      Message newRecordedMessage = Message(
        sentAt: Timestamp.now(),
        voiceFileURL: voiceFileURL,
        messageForID: currentChatDummy.chatID,
        receiverID: currentChatDummy.peerID,
        receiverName: currentChatDummy.peerName,
        senderID: AuthService().currentUserId,
        senderName: AuthService().currentUser().displayName,
      );

      await DataService().addData(collectionPath: 'messages', data: {
        'sentAt': newRecordedMessage.sentAt,
        'voiceFileURL': newRecordedMessage.voiceFileURL,
        'messageForID': newRecordedMessage.messageForID,
        'receiverID': newRecordedMessage.receiverID,
        'receiverName': newRecordedMessage.receiverName,
        'senderID': newRecordedMessage.senderID,
        'senderName': newRecordedMessage.senderName
      });
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dummyRawData =
          await DataService().getStringQuery(
              collection: 'messages',
              queryString: newRecordedMessage.voiceFileURL,
              field: 'voiceFileURL');
      newRecordedMessage = Message(
        messageID: dummyRawData[0].id,
        sentAt: dummyRawData[0].data()['sentAt'],
        voiceFileURL: dummyRawData[0].data()['voiceFileURL'],
        messageForID: dummyRawData[0].data()['messageForID'],
        receiverID: dummyRawData[0].data()['receiverID'],
        receiverName: dummyRawData[0].data()['receiverName'],
        senderID: dummyRawData[0].data()['senderID'],
        senderName: dummyRawData[0].data()['senderName'],
      );

      Map<String, dynamic> dummyChatData = await DataService()
          .getCollectionByIdQuery(
              documentID: newRecordedMessage.messageForID, collection: 'chats');
      print("DUMMY CHAT DATA ÇEKİLDİ, PEERNAMES = ");
      print(dummyChatData['peerNames']);
      print(dummyChatData['messages']);
      List dummyMessageIDList = dummyChatData['messages'];

      dummyMessageIDList.add(newRecordedMessage.messageID);
      await DataService().updateDataByID(
          collectionPath: 'chats',
          docID: newRecordedMessage.messageForID,
          field: 'messages',
          value: dummyMessageIDList);
    } else {
      await DataService().addData(collectionPath: 'chats', data: {
        'lastMessageAt': Timestamp.now(),
        'messages': [],
        'peerIDs': [AuthService().currentUserId, displayedChat.peerID],
        'peerNames': [AuthService().currentUserName(), displayedChat.peerName],
        'peerPhotoURLs': [
          AuthService().currentUser().photoURL,
          displayedChat.peerPhotoURL
        ]
      });
      List<QueryDocumentSnapshot<Map<String, dynamic>>> newChatRawData =
          await DataService().getUserChatsQuery(
              queryArray: [AuthService().currentUserId, displayedChat.peerID],
              collection: 'chats',
              field: 'peerIDs',
              orderBy: 'lastMessageAt',
              descending: false);
      print('*****************newChatRawData ? $newChatRawData');
      Chat newChat = Chat(
          chatID: newChatRawData[0].id,
          peerID: displayedChat.peerID,
          peerName: displayedChat.peerName,
          peerPhotoURL: displayedChat.peerPhotoURL,
          messages: [],
          lastMessageAt: newChatRawData[0].data()['lastMessageAt'].toDate());
      Message newRecordedMessage = Message(
        sentAt: Timestamp.fromDate(newChat.lastMessageAt),
        voiceFileURL: voiceFileURL,
        messageForID: newChat.chatID,
        receiverID: newChat.peerID,
        receiverName: newChat.peerName,
        senderID: AuthService().currentUserId,
        senderName: AuthService().currentUser().displayName,
      );
      await DataService().addData(collectionPath: 'messages', data: {
        'sentAt': newRecordedMessage.sentAt,
        'voiceFileURL': newRecordedMessage.voiceFileURL,
        'messageForID': newRecordedMessage.messageForID,
        'receiverID': newRecordedMessage.receiverID,
        'receiverName': newRecordedMessage.receiverName,
        'senderID': newRecordedMessage.senderID,
        'senderName': newRecordedMessage.senderName
      });
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dummyRawData =
          await DataService().getStringQuery(
              collection: 'messages',
              queryString: newRecordedMessage.voiceFileURL,
              field: 'voiceFileURL');
      newRecordedMessage = Message(
        messageID: dummyRawData[0].id,
        sentAt: dummyRawData[0].data()['sentAt'],
        voiceFileURL: dummyRawData[0].data()['voiceFileURL'],
        messageForID: dummyRawData[0].data()['messageForID'],
        receiverID: dummyRawData[0].data()['receiverID'],
        receiverName: dummyRawData[0].data()['receiverName'],
        senderID: dummyRawData[0].data()['senderID'],
        senderName: dummyRawData[0].data()['senderName'],
      );
      List dummyMessageIDList = [];
      dummyMessageIDList.add(newRecordedMessage.messageID);
      await DataService().updateDataByID(
          collectionPath: 'chats',
          docID: newRecordedMessage.messageForID,
          field: 'messages',
          value: dummyMessageIDList);
    }
  }

  Future uploadAudio(
      {List<Chat> userChats, Chat displayedChat, String recordFilePath}) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .refFromURL("gs://volink-41421.appspot.com")
        .child(path.basename(recordFilePath));

    UploadTask task = firebaseStorageRef.putFile(File(recordFilePath));

    task.whenComplete(() async {
      try {
        await firebaseStorageRef.getDownloadURL().then((value) {
          handleChat(
              userChats: userChats,
              displayedChat: displayedChat,
              voiceFileURL: value);
        });
      } on FirebaseException catch (e) {
        print(e.message);
      }
    });

    // Task
  }

  Future deleteFile(String path) async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      await File(path).delete();
    }
  }

  Future<bool> checkPermission() async {
    if (!await Permission.storage.isGranted) {
      PermissionStatus status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}

// then((value) async {
// print('##############done#########');
// var audioURL = await value.ref.getDownloadURL();
// String strVal = audioURL.toString();
// await sendAudioMsg(strVal);
// }).catchError((e) {
// print(e);
// });
