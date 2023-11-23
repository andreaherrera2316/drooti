import 'package:flutter/material.dart';

class SlidingWidget extends StatefulWidget {
  const SlidingWidget({
    required this.scrollController,
    required this.content,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final Widget content;
  final ScrollController scrollController;

  final double? height;
  final double? width;

  @override
  State<SlidingWidget> createState() => _SlidingWidgetState();
}

class _SlidingWidgetState extends State<SlidingWidget> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;

    var scrollView = SingleChildScrollView(
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(), // Disable user interaction
      child: SizedBox(
        child: widget.content,
      ),
    );

    return SizedBox(
      height: widget.height ?? s.height,
      width: widget.width ?? s.width,
      child: scrollView,
    );
  }
}
