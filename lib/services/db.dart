import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseFirestore get db => _db;
}