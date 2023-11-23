import 'package:app/src/data/account%20db/iaccount_db.dart';
import 'package:app/src/data/references_db.dart';
import 'package:app/src/data/username%20db/username_db.dart';
import 'package:app/src/core/entities/account/account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDB with ReferencesDB implements IAccountDatabase {
  @override
  Future<Map<String, dynamic>> getUserData(String userID) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot docSnapshot =
          await firestore.collection('users').doc(userID).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> userData =
            docSnapshot.data() as Map<String, dynamic>;
        return userData;
      }
    } catch (e) {
      return {};
    }
    return {};
  }

  ///Create's a user account, in case of error the error code will be returned
  @override
  Future<String> createAccount(AccountData accountData) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential =
          await _createUser(auth, accountData.email, accountData.password);

      _storeUserData(
          userCredential.user!.uid, accountData.email, accountData.username);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error_unknown";
    }
    return "";
  }

  ///Logs user in, in case of error the error code will be returned
  @override
  Future<String> login(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user!.uid;
      } else {
        return "error_unknown";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error_unknown";
    }
  }

  ///Send a password recoery email, in case of error the error code will be returned
  @override
  Future<String> resetPassword(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "error_unknown";
    }
    return "";
  }

  Future<UserCredential> _createUser(
      FirebaseAuth auth, String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw FailedToCreateUserError();
    }
  }

  _storeUserData(String uid, String email, String username) {
    var firestore = FirebaseFirestore.instance;
    var usernamesDB = UsernameDB();
    var usernamesDocID = usernamesDB.addUsername(uid, username);
    var batch = firestore.batch();

    var accountDocRef = accountsCollection.doc(uid);
    batch.set(accountDocRef, {
      Fields.email: email,
      Fields.username: username,
      Fields.userID: uid,
      Fields.usernamesDocRef: usernamesDocID,
    });

    batch.commit();
  }
}

class FailedToCreateUserError extends Error {
  @override
  String toString() {
    return "Error when creating Firebase User in Auth";
  }
}

class FailedToSaveUserData extends Error {
  @override
  String toString() {
    return "Error when creating saving users data in Auth";
  }
}
