class ValidateDifficulty {
  static final _instance = ValidateDifficulty._create();

  factory ValidateDifficulty() {
    return _instance;
  }
  ValidateDifficulty._create();

  int getValidDifficulty(int difficulty) {
    if (difficulty >= 10) {
      return 10;
    } else if (difficulty <= 1) {
      return 1;
    } else {
      return difficulty;
    }
  }
}
