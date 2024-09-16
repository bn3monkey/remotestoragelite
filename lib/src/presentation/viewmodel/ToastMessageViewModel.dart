import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';

class ToastMessageViewModel extends ChangeNotifier {
  String get currentMessage => _currentMessage;
  String _currentMessage = "";

  late StreamSubscription<String> _streamSubscription;

  final ShowToastMessage showToastMessage;
  ToastMessageViewModel({required this.showToastMessage}) {
    _streamSubscription = showToastMessage.link().listen(setMessage);
  }

  void setMessage(String newMessage) {
    _currentMessage = newMessage;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
