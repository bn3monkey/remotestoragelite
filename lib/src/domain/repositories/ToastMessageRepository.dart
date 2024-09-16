import 'dart:async';

abstract class ToastMessageRepository {
  StreamController<String> get message;
}
