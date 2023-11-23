// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/enemy%20manager/generator/enemy_generator.dart';
// import 'package:flame/game.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../game actions/test_game_actions.dart';

// void main() {
//   EnemyGenerator getGenerator() => EnemyGenerator(
//       enemies: SeasonalFactory(game: TestGame(), actions: TestGameActions()));
//   test("Difficulty increases", () {
//     var generator = getGenerator();
//     int current = generator.difficulty;
//     generator.increaseDifficulty();
//     expect(current < generator.difficulty, true);
//   });

//   test("When difficulty increases the generation meters get lower", () {
//     var generator = getGenerator();
//     double current = generator.genEveryMeters;
//     generator.increaseDifficulty();
//     expect(current > generator.genEveryMeters, true);
//   });

//   test("Generation of enemies get's randomized", () {
//     var generator1 = getGenerator();
//     var generator2 = getGenerator();
//     expect(generator1.genEveryMeters != generator2.genEveryMeters, true);
//   });
// }

// class TestGame extends FlameGame {}
