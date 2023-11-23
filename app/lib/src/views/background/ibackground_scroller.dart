abstract class IBackgroundScroller {
  void scrollUp(double moveByPercent);
  void scrollDown(double moveByPercent);
  double get currentOffset;
  double get maxOffset;
  double get minOffset;
}
