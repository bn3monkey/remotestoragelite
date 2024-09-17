import 'dart:typed_data';

import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';

abstract class RemoteDataSource {
  Future<bool> open(
      int port,
      void Function(Uint8List) onRead,
      void Function(AppResult result, String errorMessage) onError,
      void Function(AppResult result, String clientDescription) onDone);
  Future<void> close();
}
