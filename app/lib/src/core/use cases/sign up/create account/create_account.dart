import 'package:app/src/data/account%20db/account_db.dart';
import 'package:app/src/data/account%20db/iaccount_db.dart';
import 'package:app/src/core/entities/account/account_data.dart';
import 'package:app/src/core/use%20cases/sign%20up/create%20account/icreate_account.dart';

class CreateAccount implements ICreateAccount {
  final IAccountDatabase accountDatabase;
  CreateAccount() : accountDatabase = AccountDB();

  @override
  Future<String> createAccount(AccountData data) async {
    return await accountDatabase.createAccount(data);
  }
}
