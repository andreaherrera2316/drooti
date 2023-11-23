import 'package:app/src/views/screens/login/presenter/ilogin_presenter.dart';
import 'package:app/src/views/screens/login/view/ilogin_view.dart';

class LoginPresenter implements ILoginPresenter {
  final ILoginView view;

  LoginPresenter(this.view);

  @override
  void showError([String? error]) {
    view.showError(error);
  }

  @override
  void showSuccess() {
    view.showSuccess();
  }
}
