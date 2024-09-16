import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class OpenNetworkConnection {
  final NetworkConnectionRepository networkConnectionRepository;
  final ShowToastMessage showToastMessage;
  OpenNetworkConnection(
      {required this.networkConnectionRepository,
      required this.showToastMessage});

  Future<bool> call() async {
    bool ret = await networkConnectionRepository.openNetworkConnection();

    return ret;
  }
}
