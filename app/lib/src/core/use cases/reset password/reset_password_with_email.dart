import 'package:app/src/data/account%20db/account_db.dart';
import 'package:app/src/data/account%20db/iaccount_db.dart';
import 'package:app/src/core/use%20cases/reset%20password/ireset_password.dart';

class ResetPasswordWithEmail implements IResetPassword {
  ResetPasswordWithEmail() : accountDB = AccountDB();
  IAccountDatabase accountDB;
  @override
  Future<String> resetPassword(String email) async {
    return await accountDB.resetPassword(email);
  }
}
