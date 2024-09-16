import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';

class LoadPort {
  NetworkConnectionRepository networkConnectionRepository;
  LoadPort({required this.networkConnectionRepository});

  Future<String> call() async {
    return networkConnectionRepository.port;
  }
}
