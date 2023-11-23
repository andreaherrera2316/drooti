import 'package:flutter/material.dart';

abstract class AtmosphereColors {
  // static List<Color> _baseColors = [
  //   // Blue Area
  //   const Color(0xFFADD8E6), // Very Light Blue
  //   const Color(0xFF87CEEB), // Light Blue
  //   const Color(0xFF6495ED), // Blue
  //   const Color(0xFF1E90FF), // Vivid Blue
  //   const Color(0xFF4682B4), // Teal
  //   const Color(0xFF4169E1), // Royal Rich Blue

  //   // Orange-Red Area
  //   const Color(0xFFFF4500), // Orange-Red
  //   const Color(0xFFFFA500), // Orange
  //   const Color(0xFFFFD700), // Yellowish Orange

  //   // Sunset Transition
  //   const Color(0xFFEE82EE), // Purple
  //   const Color(0xFF8A2BE2), // Dark Purple

  //   // Night Transition
  //   const Color(0xFF483D8B), // Indigo
  //   const Color(0xFF191970), // Dark Blue-Purple
  //   const Color(0xFF00008B), // Darker Bluer Blue
  //   const Color(0xFF000000), // Black (Night)
  // ];

  static List<Color> baseColors = [
    // Blue Area
    const Color(0xFFADD8E6), // Very Light Blue
    const Color(0xFFADD8E6), // Very Light Blue

    const Color(0xFF87CEEB), // Light Blue
    const Color(0xFF87CEEB), // Light Blue

    const Color(0xFF6495ED), // Blue
    const Color(0xFF6495ED), // Blue

    const Color(0xFF1E90FF), // Vivid Blue
    const Color(0xFF1E90FF), // Vivid Blue

    const Color(0xFF4682B4), // Teal
    const Color(0xFF4682B4), // Teal

    const Color(0xFF4169E1), // Royal Rich Blue
    const Color(0xFF4169E1), // Royal Rich Blue

    const Color(0xFF8A2BE2), // Dark Purple

    // Night Transition
    const Color(0xFF483D8B), // Indigo
    const Color(0xFF483D8B), // Indigo

    const Color(0xFF191970), // Dark Blue-Purple
    const Color(0xFF191970), // Dark Blue-Purple

    const Color(0xFF00008B), // Darker Bluer Blue
    const Color(0xFF00008B), // Darker Bluer Blue

    const Color(0xFF000000), // Black (Night)
    const Color(0xFF000000), // Black (Night)
    const Color(0xFF000000), // Black (Night)
    const Color(0xFF000000), // Black (Night)
    const Color(0xFF000000), // Black (Night)

    //OuterSpace Reached
    const Color(0xFFFFA500), // Orange
    const Color(0xFFFFD700), // Yellowish Orange
    const Color(0xFFEE82EE), // Purple
    const Color(0xFF8A2BE2), // Dark Purple
    const Color(0xFF483D8B), // Indigo
    const Color(0xFF483D8B), // Indigo

    const Color(0xFF191970), // Dark Blue-Purple
    const Color(0xFF191970), // Dark Blue-Purple

    const Color(0xFF00008B), // Darker Bluer Blue
    const Color(0xFF00008B), // Darker Bluer Blue
    const Color(0xfFFFFFFF),
  ];

  static List<Color> getAtmosphereColorsFor(Color backgroundColor) {
    return [backgroundColor, ...baseColors];
  }
}
