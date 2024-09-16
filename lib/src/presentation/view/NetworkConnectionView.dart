import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remotestoragelite/src/core/util/values/config/config.dart';
import 'package:remotestoragelite/src/core/util/values/string/AppString.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/NetworkConnectionViewModel.dart';
import 'package:remotestoragelite/src/presentation/widget/AppButton.dart';
import 'package:remotestoragelite/src/presentation/widget/AppTextField.dart';
import 'package:remotestoragelite/src/presentation/widget/AppWriteableTextField.dart';

class NetworkConnectionView extends StatelessWidget {
  const NetworkConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkConnectionViewModel>(
        builder: (context, viewModel, child) => Column(children: [
              Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: AppTextField(
                            text: viewModel.ipAddress,
                            labelText: AppString.of(Config.currentLanguage)
                                .ipAddress)),
                    const SizedBox(width: 10.0),
                    Expanded(
                        flex: 1,
                        child: AppButton(
                            text: AppString.of(Config.currentLanguage)
                                .findIpAddress,
                            onPressed: viewModel.findIPAddress))
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: AppWriteableTextField(
                            controller: viewModel.portController,
                            labelText:
                                AppString.of(Config.currentLanguage).port)),
                    const SizedBox(width: 10.0),
                    Expanded(
                        flex: 1,
                        child: AppButton(
                            text: viewModel.isOpened
                                ? AppString.of(Config.currentLanguage)
                                    .closeConnection
                                : AppString.of(Config.currentLanguage)
                                    .openConnection,
                            onPressed: viewModel.isOpened
                                ? viewModel.close
                                : viewModel.open))
                  ]))
            ]));
  }
}
