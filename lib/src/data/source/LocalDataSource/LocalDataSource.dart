import 'dart:typed_data';

abstract class LocalDataSource {
  String get storagePath;
  set storagePath(String data);

  Future<bool> open(String rootPath, String fileName);
  Future<void> write(Uint8List data);
  Future<void> close();
}
