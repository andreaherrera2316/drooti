import 'package:app/helper/validate_percent.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("If a percentage is valid it gets returned ", () {
    var percent = ValidatePercent().getPercent(99);
    expect(percent, 99);
  });
  test("A valid percentage cannot be higher than 100", () {
    var percent = ValidatePercent().getPercent(101);
    expect(percent, 100);
  });
  test("A valid percentage cannot be lower than 0", () {
    var percent = ValidatePercent().getPercent(-10);
    expect(percent, 0);
  });
  test("Validate Percent object is a singleton", () {
    expect(ValidatePercent(), ValidatePercent());
  });
}
