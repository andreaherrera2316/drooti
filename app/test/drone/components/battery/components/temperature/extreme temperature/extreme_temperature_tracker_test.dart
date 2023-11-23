// import 'package:app/src/game%20rules/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_tracker.dart';
// import 'package:app/src/game%20rules/entities/drone/battery/resistance/temperature_resistance.dart';
// import 'package:app/src/game%20rules/entities/game/weather/temperature.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   test("Check for overheat when there's no overheat", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(110);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkOverheat(resistance, batteryTemperature), false);
//   });

//   test("Check for overheat when the battery did overheat", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(123);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkOverheat(resistance, batteryTemperature), true);
//   });

//   test(
//       "Check for overheat when the battery has no overheat at first but overheats later",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(110);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkOverheat(resistance, batteryTemperature), false);
//     batteryTemperature.temperatureF = 123;
//     expect(tracker.checkOverheat(resistance, batteryTemperature), true);
//   });

//   test("Check for overheat when the battery is overheat at first but cools off",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(123);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkOverheat(resistance, batteryTemperature), true);
//     batteryTemperature.temperatureF = 110;
//     expect(tracker.checkOverheat(resistance, batteryTemperature), false);
//   });

//   test(
//       "By how many degrees did temperature exceed maxTemperature when there's no overheat",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(110);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(
//         tracker.getMaxTemperatureExceededBy(resistance, batteryTemperature), 0);
//   });

//   test(
//       "By how many degrees did temperature exceed maxTemperature when there's an overheat",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(123);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(
//         tracker.getMaxTemperatureExceededBy(resistance, batteryTemperature), 1);
//   });

//   //////

//   test("Check for extreme cold when there's no extreme cold", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(60);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), false);
//   });

//   test("Check for extreme cold when there's extreme cold", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(58);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), true);
//   });

//   test(
//       "Check for extreme cold when the battery has no extreme cold at first but does later",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(110);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), false);
//     batteryTemperature.temperatureF = 58;
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), true);
//   });

//   test(
//       "Check for extreme cold when the battery is extremely cold at first but warms up",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(58);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), true);
//     batteryTemperature.temperatureF = 110;
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), false);
//   });

//   test(
//       "By how many degrees did temperature go below minTemperature when there's no extreme cold",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(110);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.getMinTemperatureBelowBy(resistance, batteryTemperature), 0);
//   });

//   test(
//       "By how many degrees did temperature go below minTemperature when theres extreme cold",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(57);
//     var tracker = ExtremeTemperatureTrackerMixed();
//     expect(tracker.getMinTemperatureBelowBy(resistance, batteryTemperature), 2);
//   });

//   test(
//       "There's no extreme cold or overheat when the battery temperature is regular",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(100);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheat(resistance, batteryTemperature), false);
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), false);
//   });

//   test("There's no extreme cold when there's an overheat", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(123);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheat(resistance, batteryTemperature), true);
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), false);
//   });

//   test("There's no overheat when there's extreme cold", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var batteryTemperature = Temperature(58);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheat(resistance, batteryTemperature), false);
//     expect(tracker.checkExtremeCold(resistance, batteryTemperature), true);
//   });

//   test("Overheat doesn't stop when there was never an overheat ", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(100);
//     var current = previous;
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheatStopped(previous, current, resistance), false);
//   });

//   test("Overheat doesn't stop when there was no an overheat but there is now",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(100);
//     var current = Temperature(123);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheatStopped(previous, current, resistance), false);
//   });

//   test("Overheat doesn't stop when there was an overheat and continues now",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(123);
//     var current = previous;
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheatStopped(previous, current, resistance), false);
//   });

//   test("Overheat stops when there was an overheat and there's not one now", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(123);
//     var current = Temperature(100);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(tracker.checkOverheatStopped(previous, current, resistance), true);
//   });

//   test("Extreme cold doesn't stop when there was never extreme cold", () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(100);
//     var current = previous;
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(
//         tracker.checkExtremeColdStopped(previous, current, resistance), false);
//   });

//   test(
//       "Extreme cold doesn't stop when there was no extreme cold but there is now",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(100);
//     var current = Temperature(58);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(
//         tracker.checkExtremeColdStopped(previous, current, resistance), false);
//   });

//   test(
//       "Extreme cold doesn't stop when there was extreme cold and continues now",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(58);
//     var current = previous;
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(
//         tracker.checkExtremeColdStopped(previous, current, resistance), false);
//   });

//   test("Extreme cold stops when there was extreme cold and there's none now",
//       () {
//     var resistance =
//         TemperatureResistance(minTemperature: 59, maxTemperature: 122);
//     var previous = Temperature(58);
//     var current = Temperature(100);
//     var tracker = ExtremeTemperatureTrackerMixed();

//     expect(
//         tracker.checkExtremeColdStopped(previous, current, resistance), true);
//   });
// }

// class ExtremeTemperatureTrackerMixed with ExtremeTemperatureTracker {}
