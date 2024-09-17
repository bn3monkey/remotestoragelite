import 'package:remotestoragelite/src/core/util/values/config/config.dart';
import 'package:remotestoragelite/src/core/util/values/string/AppString.dart';
import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class FindIpAddress {
  final NetworkConnectionRepository networkConnectionRepository;
  final ShowToastMessage showToastMessage;
  FindIpAddress(
      {required this.networkConnectionRepository,
      required this.showToastMessage});

  Future<String> call() async {
    final ret = await networkConnectionRepository.findIPAddress();
    if (ret == "") {
      showToastMessage(
          AppString.of(Config.currentLanguage).errorCannotFindIpAddress);
    }
    return ret;
  }
}
