import 'dart:io';

import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';

class NetworkConnectionRepositoryImpl extends NetworkConnectionRepository {
  @override
  Future<String> findIPAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print("Cannot find ipAddress");
    }
    return "";
  }

  @override
  // TODO: implement ipAddress
  String get ipAddress => _ipAddress;
  String _ipAddress = "";

  @override
  // TODO: implement port
  String get port => _port;
  String _port = "2753";

  @override
  void savePort(String port) {
    _port = port;
  }

  @override
  Future<bool> openNetworkConnection() async {
    return true;
  }

  @override
  Future<void> closeNetworkConnection() async {}
}
