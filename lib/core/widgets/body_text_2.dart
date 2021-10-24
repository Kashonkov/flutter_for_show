import 'package:flutter/material.dart';

class BodyText2 extends StatelessWidget {
  final String text;
  final TextDecoration? decoration;
  final Color? color;
  final TextAlign? align;

  const BodyText2(
      this.text, {
        Key? key,
        this.color,
        this.decoration,
        this.align,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    softWrap: true,
    textAlign: align,
    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: color, decoration: decoration),
  );
}
