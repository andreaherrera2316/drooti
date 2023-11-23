import 'package:flame_rive/flame_rive.dart';

class LoadRiveArtboard {
  static RiveFile? _file;
  static final _instance = LoadRiveArtboard._create();

  factory LoadRiveArtboard() {
    return _instance;
  }

  LoadRiveArtboard._create();

  bool get fileLoaded => _file != null;

  Future<void> loadFile() async {
    try {
      _file = await RiveFile.asset('/rive/drooti.riv');
    } catch (e) {
      Future.error("Failed to load rive file LoadRiveArtboard._loadFile");
    }
  }

  Artboard? getArtboard(String asset) {
    return _file?.artboardByName(asset);
  }
}

//TODO: My games drooti sprite 
//is doing what welcome drooti should be doing 
//Maybe it's because 
//The screen is never popped 
//So the widget is alive 
//And thus controlling drooti 
//Afterwards 
//So make sure that whenever home is excited
//The animations are stopped 
//onDispose? IDK ask chatgtp 
//But that's the problem 


//Also display the background already 
//And then go back and rearrange the managers 
//Just like you did with app 
//Goodnight 