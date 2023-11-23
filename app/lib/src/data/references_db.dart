import 'package:cloud_firestore/cloud_firestore.dart';

class ReferencesDB {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  CollectionReference get accountsCollection =>
      firestore.collection('accounts');

  CollectionReference get usernamesCollection =>
      firestore.collection('usernames');
}

class Fields {
  static const String docSizeInBytes = "docSizeInBytes";
  static const String userID = "userID";
  static const String usernamesFile = "usernames_file";
  static const String email = "email";
  static const String username = "username";
  static const String usernamesDocRef = "usernames_doc";
}
