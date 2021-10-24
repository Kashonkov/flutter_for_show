import 'package:flutter/material.dart';

class PositionedAligned extends StatelessWidget {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final Alignment alignment;
  final Widget child;

  const PositionedAligned({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        bottom: bottom,
        right: right,
        left: left,
        child: Align(
          alignment: alignment,
          child: child,
        ),
      );
}
