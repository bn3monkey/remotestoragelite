import 'package:flutter/material.dart';
import 'package:remotestoragelite/src/domain/usecases/CloseNetworkConnection.dart';
import 'package:remotestoragelite/src/domain/usecases/FindIpAddress.dart';
import 'package:remotestoragelite/src/domain/usecases/LoadPort.dart';
import 'package:remotestoragelite/src/domain/usecases/OpenNetworkConnection.dart';
import 'package:remotestoragelite/src/domain/usecases/SavePort.dart';

class NetworkConnectionViewModel extends ChangeNotifier {
  final FindIpAddress findIpAddress;
  final SavePort savePort;
  final LoadPort loadPort;
  final OpenNetworkConnection openNetworkConnection;
  final CloseNetworkConnection closeNetworkConnection;

  NetworkConnectionViewModel(
      {required this.findIpAddress,
      required this.savePort,
      required this.loadPort,
      required this.openNetworkConnection,
      required this.closeNetworkConnection}) {
    _portController.addListener(_setPort);
  }

  @override
  void dispose() {
    _portController.removeListener(_setPort);
    super.dispose();
  }

  void _setPort() {
    savePort(_portController.text);
  }

  String get ipAddress => _ipAddress;
  TextEditingController get portController => _portController;
  bool get isOpened => _isOpened;

  Future<void> findIPAddress() async {
    _ipAddress = await findIpAddress();
    notifyListeners();
  }

  Future<void> open() async {
    _isOpened = await openNetworkConnection();
    print("Open!");
    notifyListeners();
  }

  Future<void> close() async {
    await closeNetworkConnection();
    _isOpened = false;
    print("Close!");
    notifyListeners();
  }

  String _ipAddress = "";
  final TextEditingController _portController = TextEditingController();
  bool _isOpened = false;
}
