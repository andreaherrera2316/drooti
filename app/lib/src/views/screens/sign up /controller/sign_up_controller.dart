import 'package:app/src/core/entities/account/account_data.dart';
import 'package:app/src/core/use%20cases/sign%20up/username%20available/iusername_available.dart';
import 'package:app/src/core/use%20cases/sign%20up/username%20available/username_available.dart';
import 'package:app/src/views/screens/sign%20up%20/controller/isign_up_controller.dart';
import 'package:app/src/views/screens/sign%20up%20/presenter/isign_up_presenter.dart';

class SignUpController implements ISignUpController {
  SignUpController({
    required this.presenter,
  });

  final ISignUpPresenter presenter;

  @override
  Future<bool> checkIsUsernameAvailable(String username) async {
    IUsernameAvailable usernameAvailable = UsernameAvailable();
    return await usernameAvailable.checkUsernameAvailable(username);
  }

  @override
  void onSignUpBtnPressed({
    required String email,
    required String username,
    required String password,
  }) async {
    final accountData =
        AccountData(email: email, username: username, password: password);

    // String errorCode = await CreateAccount().createAccount(accountData);
    // bool success = errorCode.isEmpty;
    // if (success) {
    print("SHOW SUCCESS");
    presenter.showSuccess();
    // } else {
    //   presenter.showError(errorCode);
    // }
  }
}


//Okay so i need to add riverpod 
//and create a provider for the background 
//and a provider for the account 
//show a banner with the a score, and restart game button 
//that is it 
//then we are done! we upload it and of to the city that never sleeps 

