import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference instructorsCollection = Firestore.instance.collection('instructors');

  Future<void> updateUserData(String name, String surname, int sumup) async {
    return await instructorsCollection.document(uid).setData({
      'name': name,
      'surname': surname,
      'sumup': sumup,
    });
  }

  // get brews stream
  Stream<QuerySnapshot> get instructors {
    return instructorsCollection.snapshots();
  }

}