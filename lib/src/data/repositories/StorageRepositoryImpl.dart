import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';
import 'package:remotestoragelite/src/data/source/LocalDataSource/LocalDataSource.dart';
import 'package:remotestoragelite/src/domain/repositories/StorageRepository.dart';
import 'package:file_selector/file_selector.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

class StorageRepositoryImpl extends StorageRepository {
  LocalDataSource localDataSource;
  StorageRepositoryImpl({required this.localDataSource});

  @override
  String get storagePath => localDataSource.storagePath;

  @override
  Future<AppResult> autoFindDirectory() async {
    final docuemntDirectory = await getApplicationDocumentsDirectory();
    Logger()
        .d("Application Document Directoriy Path : ${docuemntDirectory.path}");

    if (!await docuemntDirectory.exists()) {
      return AppResult.cannotAccessDirectory;
    }

    final newPath = p.join(docuemntDirectory.path, "AlimData");
    Logger().d("New Path is $newPath");

    final subDirectory = Directory(newPath);
    subDirectory.createSync(recursive: true);

    if (!await subDirectory.exists()) {
      return AppResult.cannotCreateRemoteStorageDirectory;
    }

    localDataSource.storagePath = subDirectory.path;

    sendDirectoryEvent(Directory(localDataSource.storagePath));
    _registerWatcher(localDataSource.storagePath);

    return AppResult.success;
  }

  @override
  Future<AppResult> findDirectory() async {
    final initialDirectory = await getDownloadsDirectory();
    final initialPath = initialDirectory?.path;

    final String? directoryPath =
        await getDirectoryPath(initialDirectory: initialPath);

    if (directoryPath == null) return AppResult.cannotAccessDirectory;

    localDataSource.storagePath = directoryPath;

    sendDirectoryEvent(Directory(localDataSource.storagePath));
    _registerWatcher(localDataSource.storagePath);

    return AppResult.success;
  }

  DirectoryWatcher? _directoryWatcher;
  StreamSubscription<WatchEvent>? _subscription;

  Future<void> _registerWatcher(String path) async {
    if (_directoryWatcher != null) {
      await _subscription?.cancel();
      _directoryWatcher = null;
    }

    _directoryWatcher = DirectoryWatcher(path);
    _subscription = _directoryWatcher?.events.listen((event) {
      Logger().d("Directory Watch Event occurred");
      sendDirectoryEvent(Directory(path));
    });
  }

  @override
  void sendDirectoryEvent(Directory directory) {
    directoryStream.sink.add(directory);
  }

  @override
  // TODO: implement directoryStream
  StreamController<Directory> get directoryStream => _directoryStream;
  final _directoryStream = StreamController<Directory>();
}
