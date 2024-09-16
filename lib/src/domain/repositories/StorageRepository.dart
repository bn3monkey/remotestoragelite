import 'dart:async';
import 'dart:io';

import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';

abstract class StorageRepository {
  String get storagePath;

  Future<AppResult> findDirectory();
  Future<AppResult> autoFindDirectory();

  StreamController<Directory> get directoryStream;
  void sendDirectoryEvent(Directory directory);
}
