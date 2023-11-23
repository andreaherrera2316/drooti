import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/scroll/ibackground_scroll_manager.dart';
import 'package:app/src/views/background/ibackground_scroller.dart';

class BackgroundScrollManager implements IBackgroundScrollManager {
  BackgroundScrollManager({
    required this.scroller,
  });
  @override
  IBackgroundScroller scroller;

  late Timer _timer;
  bool _pause = false;

  @override
  void scroll() {
    if (!_pause) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        onTick();
      });
    }

    _pause = false;
  }

  @override
  void pause() {
    _pause = true;
  }

  @override
  void end() {
    _timer.cancel();
  }

  void onTick() {
    if (!_pause) {
      scroller.scrollUp(100);
    }
  }
}
