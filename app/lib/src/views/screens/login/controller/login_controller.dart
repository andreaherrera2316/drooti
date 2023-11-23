import 'package:app/src/core/use%20cases/login/login_user.dart';
import 'package:app/src/core/use%20cases/sign%20up/username%20available/iusername_available.dart';
import 'package:app/src/core/use%20cases/sign%20up/username%20available/username_available.dart';
import 'package:app/src/views/screens/login/controller/ilogin_controller.dart';
import 'package:app/src/views/screens/sign%20up%20/presenter/isign_up_presenter.dart';

class LoginController implements ILoginController {
  LoginController({
    required this.presenter,
  });

  final ISignUpPresenter presenter;

  Future<bool> checkIsUsernameAvailable(String username) async {
    IUsernameAvailable usernameAvailable = UsernameAvailable();
    return await usernameAvailable.checkUsernameAvailable(username);
  }

  @override
  void onLoginBtnPressed({
    required String email,
    required String password,
  }) async {
    String errorCode = await LoginUser().login(email, password);
    bool success = errorCode.isEmpty;
    if (success) {
      presenter.showSuccess();
    } else {
      presenter.showError(errorCode);
    }
  }
}
