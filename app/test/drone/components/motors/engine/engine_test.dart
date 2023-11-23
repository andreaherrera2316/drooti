// import 'package:app/src/game%20rules/entities/drone/motor/engine/engine.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   test("Engine health increases", () {
//     double intialHealth = 80;
//     var engine = Engine(health: intialHealth);
//     double increase = 10;
//     engine.repair(increase);
//     expect(engine.health, intialHealth + increase);
//   });

//   test("Engine health decreases", () {
//     double intialHealth = 80;
//     var engine = Engine(health: intialHealth);
//     double decrease = 10;
//     engine.damage(decrease);
//     expect(engine.health, intialHealth - decrease);
//   });

//   test("Engine health cannot be set to more than 100", () {
//     var engine = Engine(health: 101);
//     expect(engine.health, 100);
//   });

//   test("Engine health cannot be increased to more than 100", () {
//     var engine = Engine(health: 100);
//     engine.repair();
//     expect(engine.health, 100);
//   });

//   test("Engine health cannot be set to lower than 0", () {
//     var engine = Engine(health: -1);
//     expect(engine.health, 0);
//   });

//   test("Engine health cannot be decrease to less than 0", () {
//     var engine = Engine(health: 0);
//     engine.damage();
//     expect(engine.health, 0);
//   });
// }
