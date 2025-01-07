import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  CustomTextField({required this.labelText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
    );
  }
}
