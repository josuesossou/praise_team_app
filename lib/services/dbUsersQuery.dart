import 'package:cloud_firestore/cloud_firestore.dart';
import './db.dart';

class DbUsers {
  final FirebaseFirestore db = Db().db;
  final String parentCollectionPath = 'organization';
  final String childCollectionPath = 'users';

  Future<DocumentSnapshot> getUser(String organizationId, String personalEmail) {
    return db.collection(parentCollectionPath)
              .doc(organizationId)
              .collection(childCollectionPath)
              .doc(personalEmail)
              .get();
  }

  Future<bool> checkUser(String userEmail, String organizationId) async {
    DocumentSnapshot user = await db.collection(parentCollectionPath)
            .doc(organizationId)
            .collection(childCollectionPath)
            .doc(userEmail)
            .get();

    return user.exists;
  }
}