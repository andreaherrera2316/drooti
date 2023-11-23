import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.labelText,
    required this.initialValue,
    required this.onChanged,
    this.validation,
    this.onErrorMessage,
    this.textColor = Colors.black,
    this.fieldOutlineColor = Colors.greenAccent,
    this.errorTextStyle,
    this.maxLines = 1,
    this.suffixIcon,
    this.placeholder,
    this.obscure = false,
    this.iconColor = Colors.grey,
  }) : super(key: key);

  final String labelText;
  final String initialValue;
  final Function(String) onChanged;
  final bool Function(String)? validation;
  final String? onErrorMessage;
  final int maxLines;
  final Color textColor;
  final Color fieldOutlineColor;
  final TextStyle? errorTextStyle;
  final Widget? suffixIcon;
  final String? placeholder;
  final bool obscure;
  final Color iconColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? errorText;
  bool showPlaceholder = true;

  String? _validate(String value) {
    if (widget.validation != null) {
      return widget.validation!(value) ? null : widget.onErrorMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(8.0);
    var fieldPadding = const EdgeInsets.all(16.0);

    var titleStyle = TextStyle(
      color: widget.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    var title = Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(widget.labelText, style: titleStyle),
    );

    var text = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        validator: (value) => _validate(value ?? ""),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: widget.maxLines,
        initialValue: widget.initialValue,
        style: titleStyle,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          iconColor: widget.iconColor,
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: fieldPadding,
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: widget.fieldOutlineColor,
              width: 2.0,
            ),
          ),
          suffixIcon: widget.suffixIcon,
          hintText: showPlaceholder ? widget.placeholder : '',
        ),
        onChanged: (value) {
          setState(() {
            showPlaceholder = value.isEmpty;
            errorText = null;
          });
          widget.onChanged(value);
        },
        // onFieldSubmitted: (value) => _validate(value),
      ),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  errorText!,
                  style: widget.errorTextStyle,
                ),
              ),
            text,
          ],
        ),
      ),
    );
  }
}
