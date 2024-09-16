import 'dart:io';

import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/domain/repositories/StorageRepository.dart';

class UpdateDirectory {
  final StorageRepository storageRepository;
  UpdateDirectory({required this.storageRepository});

  Stream<Directory> link() {
    return storageRepository.directoryStream.stream.map((event) {
      Logger().d("New Directory : ${event}");
      return event;
    });
  }

  void call(Directory newDirectory) {
    storageRepository.sendDirectoryEvent(newDirectory);
  }
}
