import 'dart:async';

import 'package:remotestoragelite/src/domain/repositories/ToastMessageRepository.dart';

class ToastMessageRepositoryImpl extends ToastMessageRepository {
  @override
  StreamController<String> get message => _message;

  final StreamController<String> _message = StreamController<String>();
}
