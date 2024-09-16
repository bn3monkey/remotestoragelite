import 'package:flutter/material.dart';

class AppTextBox extends StatelessWidget {
  final String text;

  const AppTextBox({super.key, required this.text});

  @override
  build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0)),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.0,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.normal)));
  }
}
