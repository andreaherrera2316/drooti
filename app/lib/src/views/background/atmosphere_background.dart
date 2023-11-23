import 'package:flutter/material.dart';

class AtmosphereBackground extends StatelessWidget {
  final List<Color> atmosphereColors;
  final ScrollController scrollController;

  const AtmosphereBackground(
      {required this.scrollController,
      required this.atmosphereColors,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return _atmosphereLayers(s.height, s.width, atmosphereColors);
  }
}

Widget _atmosphereLayers(
    double height, double width, List<Color> atmosphereColors) {
  var layersHeight = height * atmosphereColors.length;

  return Container(
    height: layersHeight,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: atmosphereColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}
