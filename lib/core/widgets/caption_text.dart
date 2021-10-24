import 'package:flutter/material.dart';
import 'package:flutter_for_show/core/extensions/color_scheme_extensions.dart';

class CaptionText extends StatelessWidget{
  final String text;
  final Color? color;

  const CaptionText(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text, style: Theme.of(context).textTheme.caption!.copyWith(color: color ?? Theme.of(context).colorScheme.optional2),);
}