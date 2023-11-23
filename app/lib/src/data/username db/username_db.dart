import 'package:app/helper/data_size_calculator.dart';
import 'package:app/src/data/account%20db/account_db.dart';
import 'package:app/src/data/references_db.dart';
import 'package:app/src/data/username%20db/iusername_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsernameDB with ReferencesDB implements IUsernameDB {
  // ignore: constant_identifier_names
  static const BYTES_LIMIT = 1020000; //Doc Max Bytes 1,048,576

  @override
  Future<bool> isUsernameAvailable(String username) async {
    try {
      QuerySnapshot querySnapshot = await usernamesCollection
          .where(username, isEqualTo: username)
          .limit(1)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateUsername(String userID, String username) async {
    var accountDB = AccountDB();
    var userData = await accountDB.getUserData(userID);
    if (userData.isNotEmpty) {
      var usernamesRefForUser = userData[Fields.usernamesDocRef];
      var usernamesDoc = usernamesCollection.doc(usernamesRefForUser);
      usernamesDoc.update({
        userID: username,
      });
    }
  }

  //Stores a users {userID: username} in a usernames doc, the username's doc id will be returned
  @override
  Future<String> addUsername(String userID, String username) async {
    int docCount = await _getDocumentCount(usernamesCollection);
    int lastDocIndex = docCount - 1;
    bool collectionIsEmpty = lastDocIndex > 0;
    var data = {userID: username};
    int dataBytes = DataSizeCalculator().calculateSize(data);
    DocumentReference usernamesDoc;

    if (collectionIsEmpty) {
      usernamesDoc = _createUsernamesDocRef(0);
      _initializeCollection(usernamesDoc, userID, username, dataBytes);
    } else {
      usernamesDoc = _createUsernamesDocRef(lastDocIndex);
      _updateLastDoc(usernamesDoc, userID, username, dataBytes);

      _checkIfLastDocFull(usernamesDoc, lastDocIndex, dataBytes);
    }

    return usernamesDoc.id;
  }

  Future<int> _getDocumentCount(CollectionReference collection) async {
    try {
      QuerySnapshot querySnapshot = await collection.get();
      return querySnapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  DocumentReference _createUsernamesDocRef(int index) {
    return usernamesCollection.doc("${Fields.usernamesFile}_$index");
  }

  Future<void> _initializeCollection(DocumentReference usernamesDoc,
      String userID, String username, int dataBytes) async {
    await usernamesDoc.set({
      userID: username,
      Fields.docSizeInBytes: dataBytes,
    });
  }

  Future<void> _updateLastDoc(DocumentReference usernamesDoc, String userID,
      String username, int dataBytes) async {
    await usernamesDoc.update({
      userID: username,
      Fields.docSizeInBytes: FieldValue.increment(dataBytes),
    });
  }

  //check lastDoc if the document is full, create another one
  Future<void> _checkIfLastDocFull(DocumentReference lastUsernamesDoc,
      int lastDocIndex, int dataBytes) async {
    await lastUsernamesDoc.get().then((DocumentSnapshot doc) async {
      var docSize = doc[Fields.docSizeInBytes];

      if (docSize >= BYTES_LIMIT) {
        _onLastDocFull(lastDocIndex);
      }
    });
  }

  Future<void> _onLastDocFull(int lastDocIndex) async {
    var newDocRef = _createUsernamesDocRef(lastDocIndex + 1);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(newDocRef, {
        Fields.docSizeInBytes: 0,
      });
    });
  }
}
