abstract class ILoginUser {
  Future<String> login(String email, String password);
}
