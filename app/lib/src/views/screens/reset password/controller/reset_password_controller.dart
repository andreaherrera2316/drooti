import 'package:app/src/core/use%20cases/reset%20password/reset_password_with_email.dart';
import 'package:app/src/views/screens/reset%20password/controller/ireset_password_controller.dart';
import 'package:app/src/views/screens/reset%20password/presenter/ireset_password_presenter.dart';

class ResetPasswordController implements IResetPasswordController {
  ResetPasswordController({
    required this.presenter,
  });

  final IResetPasswordPresenter presenter;

  @override
  void onResetBtnPressed({required String email}) async {
    String errorCode = await ResetPasswordWithEmail().resetPassword(email);
    bool success = errorCode.isEmpty;
    if (success) {
      presenter.showSuccess();
    } else {
      presenter.showError(errorCode);
    }
  }
}
