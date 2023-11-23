import 'package:app/src/core/entities/drone/battery/power/battery_power.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../subscribers/out of power/test_out_of_power_subscriber.dart';

void main() {
  test("No amount decrease should make the battery go below 0", () {
    var power = BatteryPower(
      amps: 270,
    );

    power.decreaseCharge(300);
    expect(power.ampsRemaining, 0);
    expect(power.batteryPercentage, 0);
  });

  test("No amount of increase should make the battery go above it's capacity",
      () {
    var power = BatteryPower(
      amps: 270,
      ampsRemaining: 0,
    );

    power.increaseCharge(300);
    expect(power.ampsRemaining, 270);
    expect(power.batteryPercentage, 100);
  });

  test("Decreasing capacity works the same when given a negative number ", () {
    var power = BatteryPower(
      amps: 270,
    );

    power.decreaseCharge(-10);
    expect(power.ampsRemaining, 260);
  });

  test("Increasing capacity works the same when given a negative number ", () {
    var power = BatteryPower(
      amps: 270,
      ampsRemaining: 0,
    );

    power.increaseCharge(-10);
    expect(power.ampsRemaining, 10);
  });

  test("Battery amps cannot be negative instead it's absolute value it taken",
      () {
    var power = BatteryPower(
      amps: -270,
    );

    expect(power.ampsRemaining == 270, true);
  });

  test("Amps remaining cannot be negative instead it's absolute value it taken",
      () {
    var power = BatteryPower(
      amps: 270,
      ampsRemaining: -200,
    );

    expect(power.ampsRemaining == 200, true);
  });

  test("Out of power subscribers added get updates", () {
    var power = BatteryPower(
      amps: 270,
    );
    var sub = TestOutOfPowerSubscriber();
    power.addPowerSub(sub);
    expect(power.powerSubs.contains(sub), true);
  });

  test(
      "Out of power subscribers added get updated if the battery is out of power when they are added",
      () {
    var power = BatteryPower(
      amps: 270,
      ampsRemaining: 0,
    );
    var sub = TestOutOfPowerSubscriber();
    power.decreaseCharge(100);
    power.addPowerSub(sub);
    expect(sub.outOfPower, true);
  });

  test(
      "Test Out of power notifier updates it's subscribers only when the battery runs out of power",
      () {
    var power = BatteryPower(
      amps: 270,
    );
    var sub = TestOutOfPowerSubscriber();
    power.addPowerSub(sub);
    expect(sub.outOfPower, false);
    power.decreaseCharge(300);
    expect(sub.outOfPower, true);
  });

  test("Out of power subscribers removed stop getting updates", () {
    var power = BatteryPower(
      amps: 270,
    );
    var sub = TestOutOfPowerSubscriber();
    power.addPowerSub(sub);
    power.decreaseCharge(300);
    expect(sub.outOfPower, true);
    expect(power.powerSubs.contains(sub), true);

    sub.outOfPower = false;
    expect(sub.outOfPower, false);

    power.removePowerSub(sub);
    expect(power.powerSubs.contains(sub), false);

    power.decreaseCharge(10);
    expect(sub.outOfPower, false);
  });
}
