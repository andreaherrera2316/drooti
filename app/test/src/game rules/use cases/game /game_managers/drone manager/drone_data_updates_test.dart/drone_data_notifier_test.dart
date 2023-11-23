import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone_vitals_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../entities/drone/test_drone.dart';
import 'test_drone_data_sub.dart';

void main() {
  group('DroneDataNotifier', () {
    test('drone data sub can be added', () {
      var notifier = DroneVitalsNotifier();
      var subscriber = TestDroneDataSub();

      notifier.addVitalsSub(subscriber);

      expect(notifier.vitalsSubs, contains(subscriber));
    });

    test('drone data sub can be removed', () {
      var notifier = DroneVitalsNotifier();
      var subscriber = TestDroneDataSub();
      notifier.addVitalsSub(subscriber);

      notifier.removeVitalsSub(subscriber);

      expect(notifier.vitalsSubs, isNot(contains(subscriber)));
    });

    test('battery amps capacity update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.batteryAmpsCapacityUpdate();

      expect(subscriber1.batteryAmps, equals(drone.battery.amps));
      expect(subscriber2.batteryAmps, equals(drone.battery.amps));
    });

    test('battery amps remaining update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.batteryAmpsRemaningUpdate();

      expect(subscriber1.batteryAmpsRemaining,
          equals(drone.battery.ampsRemaining));
      expect(subscriber2.batteryAmpsRemaining,
          equals(drone.battery.ampsRemaining));
    });

    test('battery health update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.batteryHealthUpdate();

      expect(subscriber1.batteryHealth, equals(drone.battery.health));
      expect(subscriber2.batteryHealth, equals(drone.battery.health));
    });
    test('battery temperature update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.batteryTemperatureUpdate();

      expect(
          subscriber1.batteryTemperature, equals(drone.battery.temperatureF));
      expect(
          subscriber2.batteryTemperature, equals(drone.battery.temperatureF));
    });

    test('max speed update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.maxSpeedUpdate();

      expect(subscriber1.maxSpeed, equals(drone.motor.maxSpeed.metersPerSec));
      expect(subscriber2.maxSpeed, equals(drone.motor.maxSpeed.metersPerSec));
    });

    test('motor health update notifies subscribers', () {
      var notifier = DroneVitalsNotifier();
      var drone = TestDrone().drone;
      var subscriber1 = TestDroneDataSub();
      var subscriber2 = TestDroneDataSub();
      notifier.addVitalsSub(subscriber1);
      notifier.addVitalsSub(subscriber2);

      notifier.drone = drone;
      notifier.motorHealthUpdate();

      expect(subscriber1.motorHealth, equals(drone.motor.health));
      expect(subscriber2.motorHealth, equals(drone.motor.health));
    });
  });
}
