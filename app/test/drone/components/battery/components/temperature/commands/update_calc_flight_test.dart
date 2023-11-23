import 'package:app/src/core/entities/drone/battery/temperature/calculator/regular_calculator.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/calc%20recieve%20updates/update_calc_flight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Calculator fly status gets updated whenever there's an updates", () {
    var calculator = RegularCalculator();
    var calcConnection = UpdateCalcFlight(calculator: calculator);

    expect(calculator.isFlying, false);

    calcConnection.onFlyUpdate(true);

    expect(calculator.isFlying, true);

    calcConnection.onFlyUpdate(false);

    expect(calculator.isFlying, false);
  });
}
