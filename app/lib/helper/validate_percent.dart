class ValidatePercent {
  static final validate = ValidatePercent._getInstance();
  factory ValidatePercent() {
    return validate;
  }

  ValidatePercent._getInstance();

  double getPercent(double percent) {
    if (percent < 0) {
      return 0;
    } else {
      if (percent > 100) {
        return 100;
      } else {
        return percent;
      }
    }
  }
}
