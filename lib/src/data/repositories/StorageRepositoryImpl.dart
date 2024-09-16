import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/domain/repositories/StorageRepository.dart';
import 'package:file_selector/file_selector.dart';
import 'package:path/path.dart' as p;

class StorageRepositoryImpl extends StorageRepository {
  String get storagePath => _storagePath;
  String _storagePath = "";

  @override
  Future<AppResult> autoFindDirectory() async {
    final docuemntDirectory = await getApplicationDocumentsDirectory();
    Logger()
        .d("Application Document Directoriy Path : ${docuemntDirectory.path}");

    if (!await docuemntDirectory.exists()) {
      return AppResult.cannotAccessDirectory;
    }

    final newPath = p.join(docuemntDirectory.path, "AlimData");
    Logger().d("New Path is ${newPath}");

    final subDirectory = Directory(newPath);
    subDirectory.createSync(recursive: true);

    if (!await subDirectory.exists()) {
      return AppResult.cannotCreateRemoteStorageDirectory;
    }

    _storagePath = subDirectory.path;

    return AppResult.success;
  }

  @override
  Future<AppResult> findDirectory() async {
    final initialDirectory = await getDownloadsDirectory();
    final initialPath = initialDirectory?.path;

    final String? directoryPath =
        await getDirectoryPath(initialDirectory: initialPath);

    if (directoryPath == null) return AppResult.cannotAccessDirectory;

    _storagePath = directoryPath;
    return AppResult.success;
  }
}
