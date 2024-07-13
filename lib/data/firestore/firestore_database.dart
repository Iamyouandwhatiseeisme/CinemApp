import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDataBase {
  final CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');
  DocumentReference documentRef =
      FirebaseFirestore.instance.collection('reports').doc('1');

  Future<void> submitReport(
      {required String comment, required String message}) async {
    try {
      await reports.add({
        "message": message,
        "comment": comment,
        "read": false,
        "timeStamp": FieldValue.serverTimestamp()
      });
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
