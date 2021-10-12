import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
