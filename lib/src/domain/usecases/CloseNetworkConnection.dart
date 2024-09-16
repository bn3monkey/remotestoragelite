import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class CloseNetworkConnection {
  final NetworkConnectionRepository networkConnectionRepository;
  final ShowToastMessage showToastMessage;
  CloseNetworkConnection(
      {required this.networkConnectionRepository,
      required this.showToastMessage});

  Future<void> call() async {
    return;
  }
}
