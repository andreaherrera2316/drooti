import 'package:app/src/views/shared/text/app_text_field.dart';
import 'package:app/src/views/shared/email/email_validation.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
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
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: 'Email',
      initialValue: initialValue,
      onChanged: onChanged,
      validation: (value) => EmailValidation.isEmailValid(value),
      onErrorMessage: 'Invalid email address',
      textColor: textColor ?? Colors.black,
      fieldOutlineColor: fieldOutlineColor ?? Colors.black,
    );
  }
}
