abstract class NetworkConnectionRepository {
  String get ipAddress;
  String get port;

  Future<String> findIPAddress();
  void savePort(String port);

  Future<bool> openNetworkConnection();
  Future<void> closeNetworkConnection();
}
