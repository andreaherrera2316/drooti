// import 'package:app/src/game%20rules/entities/drone/battery/health/battery_health.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../../../subscribers/battery died/test_battery_died_subscriber.dart';

// void main() {
//   test("Health capacity cant be set higher lower than 0", () {
//     var health = BatteryHealth(initialCapacity: -10);
//     expect(health.batteryCapacity, 0);
//   });

//   test("Health capacity cant be set higher than 100", () {
//     var health = BatteryHealth(initialCapacity: 105);
//     expect(health.batteryCapacity, 100);
//   });

//   test("Reduce capacity", () {
//     var health = BatteryHealth();
//     health.reduceCapacity();
//     expect(health.batteryCapacity, 99);
//   });

//   test("Increase capacity", () {
//     var health = BatteryHealth(initialCapacity: 99);
//     health.increaseCapacity();
//     expect(health.batteryCapacity, 100);
//   });

//   test("Reduce capacity won't reduce capacity below 0", () {
//     var health = BatteryHealth();
//     health.reduceCapacity(101);
//     expect(health.batteryCapacity, 0);
//   });

//   test("Increase capacity won't increase above 100", () {
//     var health = BatteryHealth();
//     health.increaseCapacity(101);
//     expect(health.batteryCapacity, 100);
//   });

//   test("Reduce capacity works the same when given a negative number ", () {
//     var health = BatteryHealth();
//     health.reduceCapacity(-5);
//     expect(health.batteryCapacity, 95);
//   });

//   test("Increase capacity works the same when given a negative number ", () {
//     var health = BatteryHealth(initialCapacity: 90);
//     health.increaseCapacity(-5);
//     expect(health.batteryCapacity, 95);
//   });

//   test("Battery died subscribers added get updates", () {
//     var health = BatteryHealth();
//     var sub = TestBatteryDiedSubscriber();
//     health.addDiedSub(sub);
//     expect(health.diedSubs.contains(sub), true);
//   });

//   test(
//       "Battery died subscribers added get updated if the battery is dead when they are added",
//       () {
//     var health = BatteryHealth();
//     var sub = TestBatteryDiedSubscriber();
//     health.reduceCapacity(100);
//     health.addDiedSub(sub);
//     expect(sub.batteryDied, true);
//   });

//   test(
//       "Test battery died notifier updates it's subscribers only when the battery dies",
//       () {
//     var health = BatteryHealth();
//     var sub = TestBatteryDiedSubscriber();
//     health.addDiedSub(sub);
//     expect(sub.batteryDied, false);
//     health.reduceCapacity(100);
//     expect(sub.batteryDied, true);
//   });

//   test("Battery died subscribers removed stop getting updates", () {
//     var health = BatteryHealth();
//     var sub = TestBatteryDiedSubscriber();
//     health.addDiedSub(sub);
//     health.reduceCapacity(100);
//     expect(sub.batteryDied, true);
//     expect(health.diedSubs.contains(sub), true);

//     sub.batteryDied = false;
//     expect(sub.batteryDied, false);

//     health.removeDiedSub(sub);
//     expect(health.diedSubs.contains(sub), false);

//     health.reduceCapacity(10);
//     expect(sub.batteryDied, false);
//   });
// }
