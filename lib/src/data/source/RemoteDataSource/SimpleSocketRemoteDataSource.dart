import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/data/source/RemoteDataSource/RemoteDataSource.dart';

class SimpleSocketRemoteDataSource extends RemoteDataSource {
  ServerSocket? _server;

  @override
  Future<void> close() async {
    await _server?.close();
    _server = null;
  }

  @override
  Future<bool> open(
      int port,
      void Function(Uint8List) onRead,
      void Function(AppResult, String) onError,
      void Function(AppResult, String) onDone) async {
    if (_server == null) {
      final server =
          await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
      _server = server;

      Logger().d("Server Started ${server.address.address}:${server.port}");

      server.listen((client) {
        client.listen(onRead, onError: (Object error) {
          final errorDescription = "$error";
          onError(AppResult.errorSocketRead, errorDescription);
        }, onDone: () {
          onDone(AppResult.success,
              "${client.remoteAddress.address}:${client.remotePort}");
        });
      });
    }

    return true;
  }
}
