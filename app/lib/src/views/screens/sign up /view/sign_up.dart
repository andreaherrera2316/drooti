// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/resources/sizing/device_type.dart';
import 'package:app/resources/sizing/screen_size.dart';
import 'package:app/src/views/screens/sign%20up%20/controller/isign_up_controller.dart';
import 'package:app/src/views/screens/sign%20up%20/controller/sign_up_controller.dart';
import 'package:app/src/views/screens/sign%20up%20/presenter/sign_up_presenter.dart';
import 'package:app/src/views/screens/sign%20up%20/view/isign_up_view.dart';
import 'package:app/src/views/shared/text/app_title.dart';
import 'package:app/src/views/shared/widgets/custom_appbar.dart';
import 'package:app/src/views/shared/text/email_text_field.dart';
import 'package:app/src/views/shared/buttons/game_button.dart';
import 'package:app/src/views/design/palette.dart';
import 'package:app/src/views/shared/text/password_text_field.dart';
import 'package:app/src/views/shared/text/username_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> implements ISignUpView {
  _SignUpViewState() {
    controller = SignUpController(presenter: SignUpPresenter(this));
  }
  late final ISignUpController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _emailValue = '';
  String _usernameValue = '';
  String _passwordValue = '';
  String _errorMessage = '';
  bool _showSuccess = false;
  bool _showError = false;

  void _changeEmailValue(String value) {
    _emailValue = value;
  }

  void _changeUsernameValue(String value) {
    _usernameValue = value;
  }

  void _changePasswordValue(String value) {
    _passwordValue = value;
  }

  @override
  Widget build(BuildContext context) {
    Size s = ScreenSize.getSize(context);
    final l = AppLocalizations.of(context)!;
    final d = DeviceType(s.width, s.height);
    // var sizes = Sizes(height: s.height, width: s.width);
    var space = const SizedBox(height: 20);
    var p = Palette();
    if (_showSuccess) {
      showResultDialog(
          context, 'Success', l.welcomeNewUser, 'assets/success.jpg');
      _showSuccess = false;
    }
    if (_showError) {
      _errorMessage = _errorMessage.isEmpty ? l.error : _errorMessage;
      var errorMessage = LoginErrorCode(l).getErrorMessage(_errorMessage);
      showResultDialog(context, l.error, errorMessage, 'assets/error.jpg');
      _showError = false;
    }

    ///Title
    double titleSize = 50;
    var title = AppTitle(
      text: l.signUp,
      titleSize: titleSize,
    );

    ///Fields
    var fieldLabelColor = p.emeraldsColors[1].withOpacity(0.4);

    var emailField = EmailTextField(
      initialValue: _emailValue,
      onChanged: _changeEmailValue,
      textColor: p.crownSilver,
      fieldOutlineColor: fieldLabelColor,
    );

    var usernameField = UsernameTextField(
      initialValue: _usernameValue,
      onChanged: _changeUsernameValue,
      textColor: p.crownSilver,
      fieldOutlineColor: fieldLabelColor,
      checkIsUsernameAvailable: controller.checkIsUsernameAvailable,
    );

    var passwordField = PasswordTextField(
      initialValue: _passwordValue,
      onChanged: _changePasswordValue,
      textColor: p.crownSilver,
      fieldOutlineColor: fieldLabelColor,
    );

    ///Button
    var btnHeight = s.height * 0.075;
    var btnWidth = d.getValueForScreen(
            onMobile: btnHeight * 2,
            onTablet: btnHeight * 2.5,
            onDesktop: btnHeight * 3) ??
        btnHeight * 2;

    var signUpBtn = GameButton(
      colors: p.emeraldsColors,
      text: l.signUp,
      height: btnHeight,
      width: btnWidth,
      onPressed: () {
        controller.onSignUpBtnPressed(
          email: _emailValue,
          username: _usernameValue,
          password: _passwordValue,
        );
      },
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title,
                space,
                emailField,
                space,
                usernameField,
                space,
                passwordField,
                space,
                signUpBtn,
                space,
                space,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showResultDialog(
      BuildContext context, String title, String subtitle, String img) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                img,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void showSuccess() {
    setState(() {
      _showSuccess = true;
    });
  }

  @override
  void showError([String? error]) {
    setState(() {
      _showError = true;
    });
  }
}

class LoginErrorCode {
  LoginErrorCode(this.l);
  AppLocalizations l;

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return l.errorInvalidEmail;
      case 'weak-password':
        return l.errorMinCharacters;
      case 'email-already-in-use':
        return l.errorEmailAlreadyInUse;
      case 'user-not-found':
        return l.errorUserNotFound;
      case 'wrong-password':
        return l.errorWrongPassword;
      case 'user-disabled':
        return l.errorUserDisabled;
      case 'too-many-requests':
        return l.errorLoginTooManyRequests;
      case 'operation-not-allowed':
        return l.errorLoginOperationNotAllowed;
      default:
        return l.error;
    }
  }
}
