abstract class ILoadGame {
  int maxRetries;
  void loadGame();
  Function onError;
  Function onSuccess;
  ILoadGame({
    required this.onError,
    required this.onSuccess,
    this.maxRetries = 3,
  });
}
