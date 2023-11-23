import 'package:app/src/data/username%20db/iusername_db.dart';
import 'package:app/src/data/username%20db/username_db.dart';
import 'package:app/src/core/use%20cases/sign%20up/username%20available/iusername_available.dart';

class UsernameAvailable implements IUsernameAvailable {
  UsernameAvailable() : usernameDB = UsernameDB();
  IUsernameDB usernameDB;

  @override
  Future<bool> checkUsernameAvailable(String username) async {
    return await usernameDB.isUsernameAvailable(username);
  }
}
