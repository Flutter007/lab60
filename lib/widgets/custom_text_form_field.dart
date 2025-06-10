import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? helperText;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.controller,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
        ),
        validator: validator,
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}
