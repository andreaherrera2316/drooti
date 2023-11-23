import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter.dart';

class MeterLimits {
  MeterLimits({
    required double pixelsPerMeter,
    required double top,
    required double bottom,
  })  : _top = top,
        _bottom = bottom,
        _measure = Meter(pixelsPerMeter: pixelsPerMeter);

  double _top;
  double _bottom;
  final Meter _measure;

  double get pixelsPerMeter => _measure.pixelsPerMeter;

  double get top => _top;

  double get bottom => _bottom;

  set bottom(double newLimit) {
    if (newLimit < _top) {
      _bottom = newLimit;
    }
  }

  set top(double newLimit) {
    if (newLimit > _bottom) {
      _top = newLimit;
    }
  }

  void increaseLimits(double byMeters) {
    top = top + byMeters;
    bottom = bottom + byMeters;
  }
}
