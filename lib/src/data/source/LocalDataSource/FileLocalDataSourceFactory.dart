import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:remotestoragelite/src/data/source/LocalDataSource/LocalDataSource.dart';

class FileLocalDataSourceFactory extends LocalDataSource {
  File? file = null;

  @override
  Future<void> close() async {
    file = null;
  }

  @override
  Future<bool> open(String rootPath, String fileName) async {
    String fullPath = p.join(rootPath, fileName);
    file = File(fullPath);
    return file?.existsSync() ?? false;
  }

  @override
  Future<void> write(Uint8List data) async {
    file?.writeAsBytesSync(data.toList());
  }

  String _storagePath = "";
  @override
  String get storagePath {
    return _storagePath;
  }

  @override
  set storagePath(String value) {
    _storagePath = value;
  }
}
