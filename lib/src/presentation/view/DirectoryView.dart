import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remotestoragelite/src/core/util/values/config/config.dart';
import 'package:remotestoragelite/src/core/util/values/string/AppString.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/DirectoryViewModel.dart';
import 'package:remotestoragelite/src/presentation/widget/AppBorderedContainer.dart';
import 'package:remotestoragelite/src/presentation/widget/AppButton.dart';
import 'package:remotestoragelite/src/presentation/widget/AppDirectoryView.dart';
import 'package:remotestoragelite/src/presentation/widget/AppTextField.dart';

class DirectoryView extends StatelessWidget {
  const DirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectoryViewModel>(
      builder: (context, viewModel, child) => Column(
        children: [
          Expanded(
              flex: 1,
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: AppTextField(
                      text: viewModel.rootPath,
                      labelText:
                          AppString.of(Config.currentLanguage).storagePathName,
                    ))
              ])),
          const SizedBox(height: 5),
          Expanded(
              flex: 1,
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: AppButton(
                        text: AppString.of(Config.currentLanguage).autoFind,
                        onPressed: viewModel.autoFind)),
                const SizedBox(width: 10.0),
                Expanded(
                    flex: 1,
                    child: AppButton(
                        text: AppString.of(Config.currentLanguage).find,
                        onPressed: viewModel.find))
              ])),
          Expanded(
              flex: 9,
              child: AppBorderedContainer(
                  child: FileTreeView(root: viewModel.root)))
        ],
      ),
    );
  }
}
