abstract class ISignUpController {
  void onSignUpBtnPressed({
    required String email,
    required String username,
    required String password,
  });

  Future<bool> checkIsUsernameAvailable(String username);
}
