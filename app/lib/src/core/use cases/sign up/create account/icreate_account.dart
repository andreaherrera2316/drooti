import 'package:app/src/core/entities/account/account_data.dart';

abstract class ICreateAccount {
  //Creates account with the provided account data, in case of error the
  //error code will be returned else an empty string
  Future<String> createAccount(AccountData data);
}
