import 'package:flutter/material.dart';

class BodyText1 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? align;

  const BodyText1(this.text, {
    Key? key,
    this.color,
    this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(
        text,
        textAlign: align,
        style: Theme
            .of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: color),
      );
}
