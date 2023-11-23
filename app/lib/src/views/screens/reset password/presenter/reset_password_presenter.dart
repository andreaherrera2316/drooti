import 'package:app/src/views/screens/reset%20password/presenter/ireset_password_presenter.dart';
import 'package:app/src/views/screens/reset%20password/view/ireset_password_view.dart';

class ResetPasswordPresenter implements IResetPasswordPresenter {
  final IResetPasswordView view;

  ResetPasswordPresenter(this.view);

  @override
  void showError([String? error]) {
    view.showError(error);
  }

  @override
  void showSuccess() {
    view.showSuccess();
  }
}
