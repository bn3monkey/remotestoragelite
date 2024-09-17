import 'package:remotestoragelite/src/core/util/values/config/config.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/core/util/values/string/AppString.dart';
import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class OpenNetworkConnection {
  final NetworkConnectionRepository networkConnectionRepository;
  final ShowToastMessage showToastMessage;
  OpenNetworkConnection(
      {required this.networkConnectionRepository,
      required this.showToastMessage});

  void _onMessageReceived(AppResult result, String description) {
    switch (result) {
      case AppResult.success:
        showToastMessage(
            "${AppString.of(Config.currentLanguage).infoClientConnectionOver} | ($description)");
        break;
      case AppResult.fileCreate:
        showToastMessage(
            "${AppString.of(Config.currentLanguage).infoCreateFile} | ($description)");
        break;
      case AppResult.fileWrite:
        showToastMessage(
            "${AppString.of(Config.currentLanguage).infoWriteFile} | ($description)");
        break;
      case AppResult.fileClose:
        showToastMessage(
            "${AppString.of(Config.currentLanguage).infoCloseFile} | ($description)");
        break;
      case AppResult.errorSocketRead:
        showToastMessage(
            "${AppString.of(Config.currentLanguage).errorStreamError} | ($description)");
        break;
      default:
        // Do Nothing
        break;
    }
  }

  Future<bool> call() async {
    final parsedPort = int.tryParse(networkConnectionRepository.port);
    if (parsedPort == null) {
      showToastMessage(AppString.of(Config.currentLanguage).errorPortIsInvalid);
    }

    bool ret = await networkConnectionRepository.openNetworkConnection(
        parsedPort!, _onMessageReceived);
    if (!ret) {
      showToastMessage(
          AppString.of(Config.currentLanguage).errorCannotOpenServer);
    }
    return ret;
  }
}
