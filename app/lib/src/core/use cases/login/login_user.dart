import 'package:app/src/data/account%20db/account_db.dart';
import 'package:app/src/data/account%20db/iaccount_db.dart';
import 'package:app/src/core/use%20cases/login/ilogin_user.dart';

class LoginUser implements ILoginUser {
  LoginUser() : accountDB = AccountDB();
  IAccountDatabase accountDB;
  @override
  Future<String> login(String email, String password) async {
    return await accountDB.login(email, password);
  }
}
