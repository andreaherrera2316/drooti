// import 'package:app/src/views/game/game/controller/enemies/load_flame_enemy.dart';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../game/game actions/test_game_actions.dart';
// import '../game/sprites/enemy_generator_test.dart';

// void main() {
//   final game = TestGame();
//   final gameActions = TestGameActions();
//   runApp(GameWidget(game: game));

//   test('Snowball is added to game component', () async {
//     var snowball =
//         await LoadFlameEnemy().snowball(50, 50, true, gameActions, game);
//     expect(snowball.parent == game, false);
//     snowball.addToGame();
//     expect(snowball.parent == game, true);
//   });

//   test('Snowball is removed from game component', () async {
//     var snowball =
//         await LoadFlameEnemy().snowball(50, 50, true, gameActions, game);
//     expect(snowball.parent == game, false);
//     snowball.addToGame();
//     expect(snowball.parent == game, true);
//     snowball.removeFromGame();
//     expect(snowball.parent == game, false);
//   });

//   test("Snowball damages drone on collision", () async {
//     var snowball =
//         await LoadFlameEnemy().snowball(50, 50, true, gameActions, game);
//     snowball.addToGame();
//     var health = gameActions.motorHealth;
//     var weather = gameActions.weather;
//     snowball.onCollision({Vector2(0, 0)}, PositionComponent());
//     expect(health > gameActions.motorHealth, true);
//     expect(weather != gameActions.weather, true);
//   });
// }
