import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';

class SavePort {
  NetworkConnectionRepository networkConnectionRepository;
  SavePort({required this.networkConnectionRepository});

  Future<void> call(String value) async {
    networkConnectionRepository.savePort(value);
  }
}
