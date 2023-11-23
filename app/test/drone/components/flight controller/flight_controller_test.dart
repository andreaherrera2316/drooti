import 'package:app/src/core/entities/drone/flight%20controller/flight_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../subscribers/fly/test_fly_subscriber.dart';

void main() {
  test("make drone fly", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);
  });

  test("make drone stop flying", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);
    flight.stopFlying();
    expect(flight.isFlying, false);
  });

  test("Subscribers get notified of flying status when they are added", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);

    var sub = TestFlySubscriber();
    flight.addFlySub(sub);

    expect(sub.flying, true);
  });

  test("Subscribers get notified of flying status whenever it changes", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);

    var sub = TestFlySubscriber();
    flight.addFlySub(sub);

    expect(sub.flying, true);
    flight.stopFlying();
    expect(sub.flying, false);
    flight.fly();
    expect(sub.flying, true);
  });

  test(
      "Subscribers stop getting notified of flying status when they are removed",
      () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);

    var sub = TestFlySubscriber();
    flight.addFlySub(sub);

    expect(sub.flying, true);
    flight.stopFlying();
    expect(sub.flying, false);

    flight.removeFlySub(sub);
    flight.fly();
    expect(sub.flying, false);
  });

  test("Notifier does not send unecessary stopFlying updates ", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);

    var sub = TestFlySubscriber();
    flight.addFlySub(sub);

    flight.stopFlying();
    expect(sub.flying, false);

    sub.flying = true;
    flight.stopFlying();
    expect(sub.flying, true);
  });

  test("Notifier does not send unecessary fly updates ", () {
    var flight = FlightController();
    flight.fly();
    expect(flight.isFlying, true);

    var sub = TestFlySubscriber();
    flight.addFlySub(sub);

    flight.fly();
    expect(sub.flying, true);

    sub.flying = false;
    flight.fly();
    expect(sub.flying, false);
  });
}
