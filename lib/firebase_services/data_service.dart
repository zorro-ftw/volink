import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:volink/models/chat.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class DataService {
  Future getData(String collectionPath) async {
    final outputData = await firestore.collection(collectionPath).get();
    return outputData.docs;
  }

  Future addData({Map<String, dynamic> data, collectionPath}) async {
    try {
      await firestore.collection(collectionPath).add(data);
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
        .orderBy('createdAt', descending: false)
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
  Future uploadAudio(String recordFilePath) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(path.basename(recordFilePath));

    UploadTask task = firebaseStorageRef.putFile(File(recordFilePath));
    try {
      TaskSnapshot snapshot = await task;
      firebaseStorageRef.getDownloadURL().then((value) => {
            //TODO - Firebase güncellenecek
          });
    } on FirebaseException catch (e) {
      print(e.message);
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
