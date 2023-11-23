import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_subscriber.dart';

abstract class GameSizeAndDirectionSubscriber implements GameSizeSubscriber {
  ///if the positions provided are given on the assumption the top of the screen
  ///is 0 and the bottom is gameHeight then topToBottom should be true
  @override
  void onGameResize(double heightInPixels, double widthInPixels,
      [bool topToBottom = true]);
}

//okay you have to figure out whether we need a game size notifier or not 
//pro's and con's 
//So check and see 

//Then once you are done 
//fix the meter limits notifier 
//so it updates the limits every 200milli or 100
 
//And then get the displayer to move the items on the screen 
//They should start falling down 

//Then add some gravitiy 

//Then once that is done 
//Something is odd about the removeFromGame in Snowball
//So fix that and then 

//Everything should be working fine with snowball
//So fix drootis animations 

//And then give snowball animations 

//Whoohoooo Snowball is done 
//And now 

//Lets create the hit areas for drooti 
//and once see how they collide 
//Check they collide 
//And drooti is affected 
//And done

//We can start with the other enemies 
//Let's start with balls 
//Or items that move like balls 

//Test each one 
//We can write tests for this 
//Actually let's write a test for snowball 
//And se everything works properly 
//Lets do test driven development 
//For the rest of this project 
//So 
//Create and test the rest of the enemies 
//That's you job for the day 
//Start with all the ones that move 
//from side to side 
//then do the movement for the rest 
//and the extra parameters needed 

//See you here 


