// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// abstract class IShapeMaker {}

// class ShapeMaker extends StatefulWidget {
//   ShapeMaker({
//     Key? key,
//     required this.shapeCount,
//     required this.shapeColors,
//     required this.backgroundGradients,
//     required this.ovalWidth,
//     required this.ovalHeight,
//     required int minSides,
//     required int maxSides,
//   })  : _minSides = minSides,
//         _maxSides = maxSides,
//         super(key: key) {
//     minSides = _minSides;
//     maxSides = _maxSides;
//   }

//   final int shapeCount;
//   final List<Color> shapeColors;
//   final List<Color> backgroundGradients;
//   final double ovalWidth;
//   final double ovalHeight;
//   int _minSides;
//   int _maxSides;
//   List<Offset> hexagonPositions = [];

//   int get maxSides => _maxSides;
//   int get minSides => _minSides;

//   set minSides(int sides) {
//     if (sides <= 3) {
//       _minSides = 3;
//     } else {
//       _minSides = sides;
//     }
//   }

//   set maxSides(int sides) {
//     if (sides <= minSides) {
//       _maxSides = minSides;
//     } else {
//       _maxSides = sides;
//     }
//   }

//   //okay this method build all the shapes at once
//   //we need a buildShape
//   //that will build a single shape
//   //and then we can have two
//   //one with a buildShapes
//   //and one witha  buildShapesPeriodically
//   List<Widget> buildShapes(List<Color> iceColors) {
//     final random = math.Random();

//     return hexagonPositions.map((position) {
//       final iceColor = iceColors[random.nextInt(iceColors.length)];
//       final iceShapeSize = random.nextInt(20) + 30.0;
//       final rotation = random.nextDouble() * 2 * math.pi;

//       return Positioned(
//         left: position.dx,
//         top: position.dy,
//         child: Transform.rotate(
//           angle: rotation,
//           child: CustomPaint(
//             painter: ShapesPainter(
//               color: iceColor,
//               sideLength: iceShapeSize,
//               minSides: minSides,
//               maxSides: maxSides,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   //check everything is working
//   //and then buildShape
//   // Widget _buildShape() {}

//   @override
//   ShapeMakerState createState() => ShapeMakerState();
// }

// class ShapeMakerState extends State<ShapeMaker> {
//   void updateHexagonPositions() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final random = math.Random();
//     widget.hexagonPositions = [];

//     for (int i = 0; i < widget.shapeCount; i++) {
//       final x = random.nextDouble() * screenWidth;
//       final y = random.nextDouble() * screenHeight;

//       final isInOval = isPointInOval(x, y, widget.ovalWidth, widget.ovalHeight);
//       if (!isInOval) {
//         widget.hexagonPositions.add(Offset(x, y));
//       }
//     }
//   }

//   bool isPointInOval(double x, double y, double ovalWidth, double ovalHeight) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final normalizedX = x / screenWidth;
//     final normalizedY = y / screenHeight;

//     const centerX = 0.5;
//     const centerY = 0.5;

//     final distance =
//         math.pow(normalizedX - centerX, 2) / math.pow(ovalWidth, 2) +
//             math.pow(normalizedY - centerY, 2) / math.pow(ovalHeight, 2);

//     return distance <= 1;
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     updateHexagonPositions();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: widget.backgroundGradients,
//               ),
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             color: Colors.transparent,
//           ),
//         ),
//         ...widget.buildShapes(widget.shapeColors),
//       ],
//     );
//   }
// }

// class ShapesPainter extends CustomPainter {
//   ShapesPainter(
//       {required this.color,
//       required this.sideLength,
//       required this.minSides,
//       required this.maxSides});
//   final Color color;
//   final double sideLength;
//   final int minSides;
//   final int maxSides;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final icePaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final irregularHexagonPath = createShapePath(size);

//     canvas.drawPath(irregularHexagonPath, icePaint);
//   }

//   Path createShapePath(Size size) {
//     final sideCount = math.Random().nextInt(maxSides - minSides) + minSides;
//     final randomLength = math.Random();

//     final initialLength =
//         sideLength - randomLength.nextDouble() * sideLength * 0.5;

//     return ShapePath(sideCount: sideCount, sideLength: initialLength)
//         .createShapePath(size);
//   }

//   @override
//   bool shouldRepaint(ShapesPainter oldDelegate) {
//     return oldDelegate.color != color || oldDelegate.sideLength != sideLength;
//   }
// }

// class ShapePath {
//   ShapePath({
//     required this.sideCount,
//     required this.sideLength,
//   });

//   int sideCount;
//   double sideLength;

//   Path createShapePath(Size size) {
//     final randomLength = math.Random();
//     Path path = Path();

//     //this positions the shape
//     //maybe we could also make this adjustable
//     final centerX = size.width / 2;
//     final centerY = size.height / 2;

//     final initialX = centerX + sideLength * math.cos(0);
//     final initialY = centerY + sideLength * math.sin(0);

//     path.moveTo(initialX, initialY);

//     for (int i = 1; i <= sideCount; i++) {
//       final angle = 2 * math.pi * i / sideCount;
//       final length = sideLength - randomLength.nextDouble() * sideLength * 0.2;

//       final x = centerX + length * math.cos(angle);
//       final y = centerY + length * math.sin(angle);

//       path.lineTo(x, y);
//     }

//     path.close();

//     return path;
//   }
// }

// class IceScreen extends StatelessWidget {
//   const IceScreen({super.key, Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: 0.4,
//       child: ShapeMaker(
//         minSides: 3,
//         maxSides: 9,
//         shapeCount: 10 * 50,
//         ovalWidth: 0.4, // Adjust the oval width here
//         ovalHeight: 0.4, // Adjust the oval height here
//         backgroundGradients: [
//           Colors.lightBlue.withOpacity(0.8),
//           Colors.blue.withOpacity(0.5),
//         ],
//         shapeColors: [
//           Colors.blue.shade300,
//           Colors.blue.shade400,
//           Colors.blue.shade500,
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     // home: Home(),
//     localizationsDelegates: AppLocalizations.localizationsDelegates,
//     supportedLocales: [
//       Locale('en'),
//       Locale('es'),
//     ],
//   ));
// }


// //okay for starters we need to create shapes separately and just pass the info in
// //Then we can to be able to periodically
// //Call that generating shapes methods
// //And done
// //Shapes generated real time

// //okay we have to change if the changes we did worked
// //on a a note
// //maybe it's a better idea to design the classes
// //and the methods
// //and then just pass it to chatGTP
// //so it cna write the corresponding code
// //and do this with tdd development
// //write the tests
// //write the class with empty methods
// //and have chatGTP fill them
// //you would move quick
// //very quick

// //okay if i was going to make a pub dev
// //this shapes would have to move
// //i mean give the impression to be moving
// //instead
// //they are just generating
// //and when the generation limit
// //is reached
// //they just remove
// //the first one in
// //we could use a queue
// //jaja

// //are we supposed to use queues
// //or would an array do best?
// //either way
// //like that
// //it would be cool
// //i think

// //okay so let's do a shape maker interface
// //and then we can do a periodic use case
// //by extending the use case we have
// //easy override
// //the create a function
// //and done

// //then we want to change it
// //so that it can create many shapes in the center not just an oval

// //
