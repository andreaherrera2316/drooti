import 'package:app/helper/value_based_on_screen.dart';
import 'package:app/resources/sizing/device_type.dart';
import 'package:app/resources/sizing/screen_size.dart';
import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/views/background/atmosphere_colors.dart';
import 'package:app/src/views/background/sliding_widget.dart';
import 'package:app/src/views/screens/game/components/load_rive_artboard.dart';
import 'package:app/src/views/background/atmosphere_background.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundDisplay extends StatelessWidget {
  const BackgroundDisplay(
      {required this.backgroundVariant,
      required this.scrollController,
      required this.bgColor,
      Key? key})
      : super(key: key);

  final BackgroundData backgroundVariant;
  final ScrollController scrollController;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;

    final backgroundColor = Color(backgroundVariant.backgroundColor);
    final colors = [
      backgroundColor,
      ...AtmosphereColors.getAtmosphereColorsFor(bgColor)
    ];

    var atmosphere = AtmosphereBackground(
      atmosphereColors: colors,
      scrollController: scrollController,
    );

    var bg = reverseContent(
        RiveBackground(backgroundVariant: backgroundVariant.asset));

    return SizedBox(
      height: s.height,
      width: s.width,
      child: reverseContent(SlidingWidget(
          scrollController: scrollController,
          content: Column(children: [
            bg,
            atmosphere,
          ]))),
    );
  }
}

Widget reverseContent(Widget content) {
  return Transform.rotate(angle: math.pi, child: content);
}

class RiveBackground extends StatelessWidget {
  const RiveBackground({required this.backgroundVariant, super.key});
  final String backgroundVariant;

  @override
  Widget build(BuildContext context) {
    //Size s = ScreenSize.getSize(context);
    var s = MediaQuery.of(context).size;
    final d = DeviceType(s.width, s.height);
    var background = LoadRiveArtboard().getArtboard(backgroundVariant);

    if (background == null) {
      return ErrorWidget("background failed");
    }

    final fit = d.getValueForScreen(
            onMobile: BoxFit.fitHeight,
            onTablet: BoxFit.fitWidth,
            onDesktop: BoxFit.fitWidth) ??
        BoxFit.fitHeight;

    return SizedBox(
        height: ValueBasedOnScreen().getValueOnHeight(
            shortScreen: s.height * 0.8,
            mediumScreen: s.height * 0.7,
            longScreen: s.height,
            screenHeight: s.height),
        child: Rive(artboard: background, fit: fit));
  }
}
