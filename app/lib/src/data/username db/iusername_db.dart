abstract class IUsernameDB {
  Future<String> addUsername(String userID, String username);
  Future<void> updateUsername(String userID, String username);
  Future<bool> isUsernameAvailable(String username);
}
