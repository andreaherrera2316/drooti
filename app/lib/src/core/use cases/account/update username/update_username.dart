import 'package:app/src/data/username%20db/iusername_db.dart';
import 'package:app/src/data/username%20db/username_db.dart';
import 'package:app/src/core/use%20cases/account/update%20username/iupdate_username.dart';

class UpdateUsername implements IUpdateUsername {
  UpdateUsername() : usernameDB = UsernameDB();
  IUsernameDB usernameDB;

  @override
  void updateUsername(String userID, String newUsername) async {
    await usernameDB.updateUsername(userID, newUsername);
  }
}
