import 'package:app/src/core/entities/drone/battery/power/battery_power.dart';
import 'package:app/src/core/entities/drone/battery/power/state/battery_power_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Battery will be out of power whenever the battery is 0", () {
    var state =
        BatteryPowerState(power: BatteryPower(amps: 200, ampsRemaining: 0));
    expect(state.isOutOfPower, true);
  });

  test("Battery will be out of power whenever the battery is close to 0", () {
    var state =
        BatteryPowerState(power: BatteryPower(amps: 200, ampsRemaining: 0.49));
    expect(state.isOutOfPower, true);
  });
  test("Battery is fully charged whenever batteryPercentage is 100", () {
    var state =
        BatteryPowerState(power: BatteryPower(amps: 200, ampsRemaining: 200));
    expect(state.fullyCharged, true);
  });
}
