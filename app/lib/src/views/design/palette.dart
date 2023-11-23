import 'package:flutter/material.dart';

class Palette {
  static final _palette = Palette._new();

  factory Palette() => _palette;
  Palette._new();

  Color get logo => const Color(0xFF434852);
  Color get lightGrey => const Color(0xFF999fa8);
  Color get chromeSilver => const Color(0xFFD8D8D8);
  Color get silver => const Color(0xFFC4CACE);
  Color get sterlingSilver => const Color(0xFFBEC2CB);
  Color get crownSilver => const Color(0xFF96a3ac);
  Color get smurfSilver => const Color.fromARGB(255, 120, 130, 137);
  Color get darkBg => const Color(0xFF1d1f21);
  Color get bg => Colors.grey[50]!;
  List<Color> get aquaColors => [
        smurfSilver,
        crownSilver,
        sterlingSilver,
      ];
  List<Color> get blackGradients => [
        const Color.fromARGB(255, 22, 22, 22),
        const Color.fromARGB(255, 12, 12, 12),
        const Color.fromARGB(255, 10, 10, 10),
        const Color.fromARGB(255, 12, 12, 12),
        const Color.fromARGB(255, 22, 22, 22),
      ];

  List<Color> get emeraldsColors => [
        const Color.fromARGB(255, 73, 210, 35), // Lush Green
        const Color.fromARGB(255, 35, 244, 129),
        const Color.fromARGB(
            255, 35, 244, 185), // Light Fierce Green (you liked this one)
      ];

  List<Color> get oceanColors => [
        const Color(0xFF1E90FF), // Vivid Blue
        const Color(0xFF0077BE),
        const Color(0xFF40BAD2),
        const Color(0xFF00A0B0),
        const Color(0xFF0A2463),
      ];

  List<Color> get deepPurpleColors => [
        const Color(0xFF8A2BE2),
        const Color(0xFF4B0082),
        const Color(0xFF580A57),
      ];

  List<Color> get fireColors => [
        Colors.pinkAccent[400]!,
        Colors.redAccent[400]!,
        Colors.orangeAccent[700]!,
        Colors.amber[600]!,
      ];

  List<Color> get redButton => [
        Colors.redAccent[400]!,
        Colors.pinkAccent[400]!,
      ];
}
