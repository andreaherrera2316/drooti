import 'package:app/src/views/background/ibackground_scroller.dart';

abstract class IBackgroundScrollManager {
  IBackgroundScrollManager({
    required this.scroller,
  });

  IBackgroundScroller scroller;
  void scroll();
  void pause();
  void end();
}
