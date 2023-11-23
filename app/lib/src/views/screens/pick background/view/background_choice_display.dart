import 'package:app/src/views/design/palette.dart';
import 'package:app/src/views/design/styles/content_style.dart';
import 'package:flutter/material.dart';

import '../../../state/loading/loading_element.dart';
import '../presenter/background_choice.dart';

class BackgroundChoiceDisplay extends StatelessWidget {
  const BackgroundChoiceDisplay(this.bg,
      {required this.height,
      required this.width,
      required this.onTap,
      this.borderRadius = 20,
      this.backgroundIsSelected = false,
      super.key});
  final BackgroundChoice bg;
  final double height;
  final double width;
  final double borderRadius;
  final bool backgroundIsSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    var borderR = BorderRadius.circular(borderRadius);
    var p = Palette();

    var loading = Container(
        decoration: BoxDecoration(borderRadius: borderR, color: p.bg),
        height: height * 0.98,
        width: width,
        child: const LoadingElement());

    var image = ClipRRect(
      borderRadius: borderR,
      child: Image.asset(
        bg.displayImg,
        height: height * 0.98,
        fit: BoxFit.fitHeight,
      ),
    );

    var selectedShadow = [
      BoxShadow(color: Colors.blueGrey[400]!.withOpacity(0.7), blurRadius: 7),
      BoxShadow(color: p.aquaColors[0].withOpacity(0.8), blurRadius: 10),
      BoxShadow(color: p.aquaColors[1].withOpacity(0.8), blurRadius: 12)
    ];

    var background = GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: borderR,
              boxShadow: backgroundIsSelected
                  ? selectedShadow
                  : kElevationToShadow[6]),
          child: Center(child: Stack(children: [loading, image]))),
    );

    var backgroundName = Text(bg.name,
        textAlign: TextAlign.center,
        style: ContentStyle(
            shadows: kElevationToShadow[1],
            fontSize: 14.5,
            color: Colors.black,
            fontWeight: FontWeight.w500));

    return SizedBox(
      width: width,
      child: Column(
        children: [
          background,
          const SizedBox(height: 10),
          backgroundName,
        ],
      ),
    );
  }
}
