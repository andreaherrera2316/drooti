import 'dart:async';

import 'package:app/src/views/shared/text/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.checkIsUsernameAvailable,
    this.textColor,
    this.fieldOutlineColor,
  }) : super(key: key);

  final String initialValue;
  final Function(String) onChanged;
  final Color? textColor;
  final Color? fieldOutlineColor;
  final Future<bool> Function(String) checkIsUsernameAvailable;

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  Timer? _typingTimer;
  bool? isUsernameAvailable;

  void _onChangedDelayed(String value) {
    bool timerIsWaiting = _typingTimer?.isActive ?? false;

    if (timerIsWaiting) {
      _typingTimer?.cancel();
    }
    _typingTimer = Timer(const Duration(milliseconds: 2000), () {
      if (value.isNotEmpty && _validate(value)) {
        widget.checkIsUsernameAvailable(value).then((bool result) {
          setState(() {
            isUsernameAvailable = result;
          });
        });
      } else {
        setState(() {
          isUsernameAvailable = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    return AppTextField(
      labelText: l.username,
      initialValue: widget.initialValue,
      placeholder: "l.minThreeChars",
      onErrorMessage: "l.minThreeCharsRequired",
      onChanged: (String value) {
        isUsernameAvailable = null;
        _onChangedDelayed(value);
        return widget.onChanged(value);
      },
      textColor: widget.textColor ?? Colors.black,
      fieldOutlineColor: widget.fieldOutlineColor ?? Colors.black,
      suffixIcon: _buildIcon(),
      validation: _validate,
      // helperText: _buildHelperText(),
    );
  }

  bool _validate(value) => value.length >= 3;

  Widget _buildIcon() {
    if (isUsernameAvailable == null) {
      return const SizedBox.shrink(); // Hide the icon when there's no input.
    }
    return Icon(
      isUsernameAvailable!
          ? Icons.check_circle_outline_outlined
          : Icons.cancel_outlined,
      color: isUsernameAvailable! ? Colors.green : Colors.red,
    );
  }

  // String? _buildHelperText() {
  //   if (isUsernameAvailable == null) {
  //     return null;
  //   }

  //   return isUsernameAvailable!
  //       ? 'Username available'
  //       : 'Username not available';
  // }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }
}
