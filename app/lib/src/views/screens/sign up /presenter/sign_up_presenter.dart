import 'package:app/src/views/screens/sign%20up%20/presenter/isign_up_presenter.dart';
import 'package:app/src/views/screens/sign%20up%20/view/isign_up_view.dart';

class SignUpPresenter implements ISignUpPresenter {
  final ISignUpView view;

  SignUpPresenter(this.view);

  @override
  void showError([String? error]) {
    view.showError(error);
  }

  @override
  void showSuccess() {
    view.showSuccess();
  }
}
