import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/models/chat.dart';
import 'package:provider/provider.dart';
import 'package:volink/models/chat_main_data.dart';
import 'package:volink/models/chats_list_data.dart';
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
  Future handleChat(BuildContext context, String voiceFileURL) async {
    var currentChatDummy =
        Provider.of<ChatMainData>(context, listen: true).displayedChat;
    Message newRecordedMessage = Message(
      sentAt: Timestamp.now(),
      voiceFileURL: voiceFileURL,
      messageForID: currentChatDummy.chatID,
      receiverID: currentChatDummy.peerID,
      receiverName: currentChatDummy.peerName,
      senderID: AuthService().currentUserId,
      senderName: AuthService().currentUser().displayName,
    );

    for (Chat chat
        in Provider.of<ChatsListData>(context, listen: true).userChats) {
      if (chat.chatID ==
          Provider.of<ChatMainData>(context, listen: true)
              .displayedChat
              .chatID) {
        DataService().addData(collectionPath: 'messages', data: {
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
                documentID: newRecordedMessage.messageForID,
                collection: 'chats');
        List<String> dummyMessageIDList =
            dummyChatData['messages'].add(newRecordedMessage.messageID);
        DataService().updateDataByID(
            collectionPath: 'chats',
            docID: newRecordedMessage.messageForID,
            field: 'messages',
            value: dummyMessageIDList);

        break;
      }
    }
  }

  Future<String> uploadAudio(String recordFilePath) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(path.basename(recordFilePath));

    UploadTask task = firebaseStorageRef.putFile(File(recordFilePath));
    try {
      String messageFileURL = await firebaseStorageRef.getDownloadURL();
      return messageFileURL;
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
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
