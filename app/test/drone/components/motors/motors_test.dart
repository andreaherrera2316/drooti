// import 'package:app/src/game%20rules/entities/drone/energy%20consumption/energy_consumption.dart';
// import 'package:app/src/game%20rules/entities/drone/motor/motor.dart';
// import 'package:app/src/game%20rules/entities/drone/motor/speed/speed.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../subscribers/motor broke/test_motor_broke_subscriber.dart';

// void main() {
//   test("Initial health cannot be set higher than 100", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       motorHealth: 110,
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     expect(motor.health, 100);
//   });

//   test("Initial health cannot be set lower than 0", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       motorHealth: -10,
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     expect(motor.health, 0);
//   });

//   test("Setting max speed affect the motors maxSpeed", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     var speed100 = motor.maxSpeed.metersPerMin;
//     motor.maxSpeed = Speed(metersPerMin: 200);
//     expect(speed100 < motor.maxSpeed.metersPerMin, true);
//   });

//   test("Damage motor", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     motor.damage();

//     expect(motor.health, 99);
//   });

//   test("Repair motor", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       motorHealth: 99,
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     motor.repair();

//     expect(motor.health, 100);
//   });

//   test("Motor cannot be damaged below 0", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       motorHealth: 0,
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     motor.damage(-10);

//     expect(motor.health, 0);
//   });

//   test("Motor cannot be repaired above 100", () {
//     var motor = Motor(
//       consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//       maxSpeed: Speed(metersPerMin: 100),
//     );

//     motor.repair(10);
//     expect(motor.health, 100);
//   });

//   test("Motor broke subscribers added get updates", () {
//     var motor = Motor(
//         consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//         maxSpeed: Speed(metersPerMin: 100));
//     var sub = TestMotorBrokeSubscriber();
//     motor.addMotorSub(sub);
//     expect(motor.motorSubs.contains(sub), true);
//   });

//   test(
//       "Motor broke subscribers added get updated if the motor broke when they are added",
//       () {
//     var motor = Motor(
//         consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//         maxSpeed: Speed(metersPerMin: 100));
//     var sub = TestMotorBrokeSubscriber();
//     motor.damage(100);
//     motor.addMotorSub(sub);
//     expect(sub.motorBroke, true);
//   });

//   test(
//       "Test Motor broke notifier updates it's subscribers only when the motor breaks",
//       () {
//     var motor = Motor(
//         consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//         maxSpeed: Speed(metersPerMin: 100));
//     var sub = TestMotorBrokeSubscriber();
//     motor.addMotorSub(sub);
//     expect(sub.motorBroke, false);
//     motor.damage(100);
//     expect(sub.motorBroke, true);
//   });

//   test("Motor broke subscribers removed stop getting updates", () {
//     var motor = Motor(
//         consumption: EnergyConsumption(ampsConsumedPerMinute: 10),
//         maxSpeed: Speed(metersPerMin: 100));
//     var sub = TestMotorBrokeSubscriber();
//     motor.addMotorSub(sub);
//     motor.damage(100);
//     expect(sub.motorBroke, true);
//     expect(motor.motorSubs.contains(sub), true);

//     sub.motorBroke = false;
//     expect(sub.motorBroke, false);

//     motor.removeMotorSub(sub);
//     expect(motor.motorSubs.contains(sub), false);

//     motor.damage(10);
//     expect(sub.motorBroke, false);
//   });
// }
