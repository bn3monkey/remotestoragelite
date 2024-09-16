import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  // final onClick;

  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold)));
  }
}
