import 'package:app/src/views/background/ibackground_scroller.dart';
import 'package:flutter/material.dart';

class BackgroundScroller implements IBackgroundScroller {
  final ScrollController scrollController;

  BackgroundScroller(this.scrollController);

  @override
  double get maxOffset => scrollController.position.maxScrollExtent;

  @override
  double get minOffset => 0;

  @override
  double get currentOffset => scrollController.offset;

  double get maxUp => maxOffset - currentOffset;

  double get maxDown => currentOffset;

  @override
  void scrollUp(double moveByPixels, [duration = const Duration(seconds: 1)]) {
    moveByPixels = moveByPixels < maxUp ? moveByPixels : maxUp;
    double targetOffset = currentOffset + moveByPixels;
    targetOffset = targetOffset.clamp(minOffset, maxOffset);
    _scroll(targetOffset, duration);
  }

  @override
  void scrollDown(double moveByPixels,
      [duration = const Duration(seconds: 1)]) {
    moveByPixels = moveByPixels < maxDown ? moveByPixels : maxDown;
    double targetOffset = currentOffset - moveByPixels;
    targetOffset = targetOffset.clamp(minOffset, maxOffset);
    _scroll(targetOffset, duration);
  }

  void _scroll(double targetOffset, duration) {
    print("duration computed: ${duration.inMilliseconds} millis");
    scrollController.animateTo(targetOffset,
        duration: duration, curve: Curves.easeInOut);
  }
}
