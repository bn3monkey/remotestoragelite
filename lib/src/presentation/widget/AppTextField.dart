import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String text;
  final String _labelText;

  const AppTextField({super.key, required this.text, String? labelText})
      : _labelText = labelText ?? "";

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: text),
      readOnly: true,
      style: const TextStyle(fontSize: 15.0),
      decoration: InputDecoration(
          labelText: _labelText, border: const OutlineInputBorder()),
    );
  }
}
