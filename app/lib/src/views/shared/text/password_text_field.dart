import 'package:app/src/views/shared/text/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    this.fieldOutlineColor,
    this.textColor,
  }) : super(key: key);

  final String initialValue;
  final Function(String) onChanged;
  final Color? textColor;
  final Color? fieldOutlineColor;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    var icon = Icon(obscureText ? Icons.visibility_off : Icons.visibility,
        color: obscureText ? widget.textColor : widget.fieldOutlineColor);

    var iconBtn = IconButton(
      icon: icon,
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    );

    var textColor = widget.textColor ?? Colors.black;
    var fieldOutlineColor = widget.fieldOutlineColor ?? Colors.black;
    return AppTextField(
      labelText: l.password,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      validation: (value) => value.length >= 8,
      onErrorMessage: l.errorMinCharacters,
      obscure: obscureText,
      textColor: textColor,
      fieldOutlineColor: fieldOutlineColor,
      placeholder: l.minCharacters,
      suffixIcon: iconBtn,
      iconColor: fieldOutlineColor,
    );
  }
}
