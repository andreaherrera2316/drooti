import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/ibackground_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/variant/ibackground_variant_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/scroll/background_scroll_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/scroll/ibackground_scroll_manager.dart';
import 'package:app/src/views/background/ibackground_scroller.dart';
import 'package:app/src/views/background/variant%20notifier/background_variant_notifier.dart';

class BackgroundManager extends BackgroundVariantNotifier
    implements IBackgroundManager {
  BackgroundManager({
    required this.variantManager,
    required this.scroller,
    required this.travelBgIn,
  }) : scrollManager = BackgroundScrollManager(scroller: scroller) {
    start();
  }

  IBackgroundScrollManager scrollManager;
  IBackgroundVariantManager variantManager;
  IBackgroundScroller scroller;
  Duration travelBgIn;

  @override
  int get backgroundColor => variantManager.selectedVariant.backgroundColor;

  @override
  String get backgroundVariant => variantManager.selectedVariant.asset;

  @override
  void start() {
    scrollManager.scroll();
  }

  @override
  void end() {
    scrollManager.end();
  }

  @override
  void pause() {
    scrollManager.pause();
  }

  @override
  void restart() {
    scrollManager.pause();
  }

  @override
  void resume() {
    scrollManager.scroll();
  }
}

//TODO EXAMPLE
//okay so i really liked how the notifier 
//and the abckground variant class worked together
//so i want to leave that that way 
//how about i make this manager need 
//how are the relaitonships going to be 

//so okay you have one big game manager 
//which is how we are going to organize this 

//now we have managers for the main areas of the code 
//so basically we have background manager, meter limits manager, drone manager 
//etc 
//so for example the background manager 
//has other managers going on 
//like the background variant manager
//and we are doing a background scroll manager
//and then the backround managers job is to 
//control those managers according to game events
//like init, start, pause, resume, end, restart,

//we need for every manager to follow this idea 
//so yeah lets finish up with the backrgound manager first 
//and then lets make every other manager follow it's example 
     

//TODO: EXAMPLE FOR MANAGER + NOTIFIER IMPLEMENTATION
//You have notifiers all over the place 
//Lets make interfaces for all the manaagers
//if the manages need a notifiers 
//they will implement it this way 
//and then we will create an object that will 
//be the game subscriptions managers 

//that game subscription manager will have 
//all the methods to subscribe 

//and then we create the login 
//upload the game to github 

//before releasing on the app store 
//i want the game to have the best architecture possible 
//so we can implement new features quickly 
//and also we have to throughly test the game 
//we need to organize the tests 
//and tests file by file 
//the folder structures should look the same in the testing folder 
//as they do here 
//so 
//once that's done 
//we can add the ranking in 
