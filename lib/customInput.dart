import 'package:flutter/material.dart';

import 'design.dart';
class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final bool isPassField;
  final TextInputAction textInputAction;
  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPassField});
  @override
  Widget build(BuildContext context) {
    bool _isPassField = isPassField ?? false;
    return Container(

      margin: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(

          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12.0),

      ),
      child: TextField(
        focusNode: focusNode,
        obscureText: _isPassField,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          )
        ),
        style: Design.regularDarkText,
      ),
    );
  }
}
