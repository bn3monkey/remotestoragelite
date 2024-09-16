import 'package:remotestoragelite/src/core/util/values/config/config.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/core/util/values/string/AppString.dart';
import 'package:remotestoragelite/src/domain/repositories/StorageRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class AutoFindStoragePath {
  final StorageRepository storageRepository;
  final ShowToastMessage showToastMessage;

  AutoFindStoragePath(
      {required this.storageRepository, required this.showToastMessage});

  Future<String> call() async {
    final result = await storageRepository.autoFindDirectory();
    switch (result) {
      case AppResult.success:
        return storageRepository.storagePath;
      case AppResult.cannotAccessDirectory:
        showToastMessage(
            AppString.of(Config.currentLanguage).errorCannotAccessDirectory);
        break;
      case AppResult.cannotCreateRemoteStorageDirectory:
        showToastMessage(AppString.of(Config.currentLanguage)
            .errorCannotCreateRemoteStorageDirectory);
        break;
    }

    return storageRepository.storagePath;
  }
}
