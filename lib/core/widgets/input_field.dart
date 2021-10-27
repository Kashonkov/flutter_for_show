import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_for_show/core/extensions/color_scheme_extensions.dart';
import 'package:flutter_for_show/core/extensions/string_extensions.dart';
import 'package:flutter_for_show/core/widgets/local_text_provider.dart';

class InputField extends StatefulWidget {
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? initialValue;
  final String? labelText;
  final TextInputType? inputType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool maxLengthEnforced;
  final bool? enabled;
  final bool needUnderline;
  final bool expand;
  final InputDecoration? decoration;
  final bool multiline;
  final String? obscuringCharacter;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsets? paddings;
  final FocusNode? focusNode;

  const InputField(
      {Key? key,
      this.hint,
      this.maxLength,
      this.helperText,
      this.labelText,
      this.errorText,
      this.initialValue,
      this.inputType,
      this.minLines,
      this.expand = false,
      this.maxLines,
      this.decoration,
      this.maxLengthEnforced = true,
      this.enabled,
      this.multiline = false,
      this.needUnderline = true,
      this.obscuringCharacter,
      this.obscureText,
      this.inputFormatters,
      this.controller,
      this.onChange,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.style,
      this.hintStyle,
      this.paddings = EdgeInsets.zero,
      this.focusNode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() {
        setState(() {});
      });
    } else {
      _focusNode = FocusNode();
      _focusNode!.addListener(() {
        setState(() {});
      });
    }
  }

  bool hasFocus() {
    if (widget.focusNode != null) {
      return widget.focusNode!.hasFocus;
    } else {
      return _focusNode!.hasFocus;
    }
  }

  InputDecoration _defaultDecoration(
    BuildContext context, {
    String? hint,
    String? helperText,
    String? errorText,
    String? labelText,
    EdgeInsets? padding = EdgeInsets.zero,
  }) {
    return InputDecoration(
        // enabledBorder: needUnderline ? UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.underline)) : InputBorder.none,
        enabledBorder: widget.needUnderline ? null : InputBorder.none,
        focusedBorder: widget.needUnderline ? null : InputBorder.none,
        // focusedBorder: needUnderline ? UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.underlineFocused)) : InputBorder.none,
        contentPadding: padding,
        hintText: hint,
        isDense: true,
        hintMaxLines: 15,
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38))),
        hintStyle: widget.hintStyle ??
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.optional2),
        helperText: helperText,
        helperStyle: Theme.of(context).textTheme.caption!.copyWith(
            color: hasFocus() ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.optional2),
        helperMaxLines: 15,
        errorText: errorText,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.optional2),
        floatingLabelStyle: Theme.of(context).textTheme.caption!.copyWith(
            color: hasFocus() ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.optional2),
        focusColor: Theme.of(context).colorScheme.primary,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
        suffixIcon: widget.suffixIcon);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.inputType,
      minLines: widget.minLines,
      textCapitalization: TextCapitalization.sentences,
      expands: widget.expand,
      maxLines: widget.multiline && widget.maxLines == null ? null : (widget.maxLines ?? 1),
      maxLength: widget.maxLength ?? null,
      maxLengthEnforced: widget.maxLengthEnforced,
      enabled: widget.enabled ?? true,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: widget.obscuringCharacter ?? '•',
      onChanged: widget.onChange,
      focusNode: widget.focusNode ?? _focusNode,
      style: widget.style ?? Theme.of(context).textTheme.bodyText1,
      validator: widget.validator,
      decoration: _defaultDecoration(context,
          hint: widget.hint,
          helperText: widget.helperText,
          errorText: widget.errorText,
          labelText: widget.labelText,
          padding: widget.paddings),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ObscuringInputField extends StatefulWidget {
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? initialValue;
  final TextInputType? inputType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool maxLengthEnforced;
  final bool? enabled;
  final InputDecoration? decoration;
  final bool multiline;
  final String? obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;

  const ObscuringInputField({
    Key? key,
    this.hint,
    this.helperText,
    this.errorText,
    this.initialValue,
    this.inputType,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.enabled,
    this.decoration,
    this.multiline = false,
    this.obscuringCharacter,
    this.inputFormatters,
    required this.controller,
    this.onChange,
    this.validator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ObscuringInputFieldState();
}

class _ObscuringInputFieldState extends State<ObscuringInputField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) => InputField(
        hint: widget.hint,
        maxLength: widget.maxLength,
        helperText: widget.helperText,
        errorText: widget.errorText,
        initialValue: widget.initialValue,
        inputType: widget.inputType,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: widget.decoration,
        maxLengthEnforced: widget.maxLengthEnforced,
        enabled: widget.enabled,
        multiline: widget.multiline,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: _isObscured,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        validator: widget.validator,
        onChange: (value) {
          setState(() {});
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        suffixIcon: widget.controller.text.isNullOrEmpty()
            ? null
            : InkWell(
                onTap: () => setState(() {
                  _isObscured = !_isObscured;
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 8),
                  child: _isObscured
                      ? Image.asset(
                          "assets/graphics/show_icon.png",
                          width: 20,
                          height: 14,
                        )
                      : Image.asset(
                          "assets/graphics/hide_icon.png",
                          width: 20,
                          height: 14,
                        ),
                ),
              ),
      );
}

class SearchField extends StatefulWidget {
  final ValueChanged<String> onChange;
  final Duration? debounce;
  final bool enabled;
  final String? label;
  final String? hint;
  final bool showClearButton;

  const SearchField(
      {Key? key,
      required this.onChange,
      this.debounce,
      this.enabled = true,
      this.showClearButton = false,
      this.hint,
      this.label})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with LocaleTextProvider {
  Timer? timer;
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InputField(
        controller: controller,
        enabled: widget.enabled,
        labelText: widget.label,
        hint: widget.hint ?? local.search,
        paddings: null,

        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.search,
            color: controller.text.isNotEmpty
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.optional2,
            size: 24,
          ),
        ),
        onChange: (text) {
          timer?.cancel();
          setState(() {});
          timer = Timer(widget.debounce ?? Duration.zero, () {
            widget.onChange(text);
          });
        },
        suffixIcon: widget.showClearButton && controller.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  timer?.cancel();
                  controller.clear();
                  widget.onChange("");
                  setState(() {});
                },
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 24,
                ),
              )
            : null,
      );
}
