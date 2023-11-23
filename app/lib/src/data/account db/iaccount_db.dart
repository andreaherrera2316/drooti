import 'package:app/src/core/entities/account/account_data.dart';

abstract class IAccountDatabase {
  Future<String> createAccount(AccountData accountData);
  Future<Map<String, dynamic>> getUserData(String userID);
  Future<String> login(String email, String password);
  Future<String> resetPassword(String email);
}
