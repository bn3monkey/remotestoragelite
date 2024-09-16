import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/ToastMessageViewModel.dart';

class ToastMessageView extends StatelessWidget {
  const ToastMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastMessageViewModel>(
        builder: (context, viewModel, widget) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                color: Theme.of(context).colorScheme.inversePrimary,
                alignment: Alignment.center,
                child: Text(viewModel.currentMessage,
                    style: TextStyle(
                        fontSize: 20.0,
                        color:
                            Theme.of(context).colorScheme.onSecondaryFixed)))));
  }
}
