import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final TextDecoration? decoration;
  final Color? color;

  const ButtonText(
      this.text, {
        Key? key,
        this.color,
        this.decoration,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.button!.copyWith(color: color ?? Theme.of(context).colorScheme.onPrimary, decoration: decoration),
  );
}
