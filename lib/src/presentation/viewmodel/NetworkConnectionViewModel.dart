import 'package:flutter/material.dart';

class NetworkConnectionViewModel extends ChangeNotifier {
  String get ipAddress => _ipAddress;
  TextEditingController get portController => _portController;
  bool get isOpened => _isOpened;

  void findIPAddress() {}
  void openNetworkConnection() {
    _isOpened = true;
    print("Open!");
    notifyListeners();
  }

  void closeNetworkConnection() {
    _isOpened = false;
    print("Close!");
    notifyListeners();
  }

  String _ipAddress = "192.168.0.100";
  TextEditingController _portController = TextEditingController(text: "2753");
  bool _isOpened = false;
}
