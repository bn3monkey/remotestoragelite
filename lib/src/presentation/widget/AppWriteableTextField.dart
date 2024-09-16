import 'package:flutter/material.dart';

class AppWriteableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String _labelText;

  const AppWriteableTextField(
      {super.key, required this.controller, String? labelText})
      : _labelText = labelText ?? "";

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: false,
      style: const TextStyle(fontSize: 15.0),
      decoration: InputDecoration(
          labelText: _labelText, border: const OutlineInputBorder()),
    );
  }
}
