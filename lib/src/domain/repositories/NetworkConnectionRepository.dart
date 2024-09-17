import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';

abstract class NetworkConnectionRepository {
  String get ipAddress;
  String get port;

  Future<String> findIPAddress();
  void savePort(String port);

  Future<bool> openNetworkConnection(
      int port, void Function(AppResult, String) onMessageReceived);
  Future<void> closeNetworkConnection();
}
