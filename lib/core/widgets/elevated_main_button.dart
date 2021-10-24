import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_show/core/extensions/color_scheme_extensions.dart';

class ElevatedMainButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final Alignment? titleALign;

  const ElevatedMainButton({
    Key? key,
    required this.title,
    this.onTap,
    this.width,
    this.height,
    this.suffixIcon,
    this.titleALign,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.button,
        color: Colors.transparent,
        shadowColor: onTap != null ? Theme.of(context).colorScheme.primary: Colors.transparent,
        //Defi
        elevation: onTap != null ? 8 : 0,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: Container(
          height: height ?? null,
          width: width ?? null,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(32)),
            border: onTap == null ? Border.all(color: Theme.of(context).colorScheme.optional) : null,
            gradient: onTap != null
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors:  [
                      Color(0xFF13D5FF),
                      Color(0xFF12A1DE),
                    ],
                  )
                : null,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              onTap: onTap,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: titleALign ?? Alignment.center,
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: onTap != null ? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                      ),
                      if (suffixIcon != null) suffixIcon!,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
