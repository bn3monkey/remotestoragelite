import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/domain/usecases/AutoFindStoragePath.dart';
import 'package:remotestoragelite/src/domain/usecases/FindStoragePath.dart';
import 'package:remotestoragelite/src/domain/usecases/UpdateDirectory.dart';
import 'package:remotestoragelite/src/presentation/widget/AppDirectoryView.dart';

class DirectoryViewModel extends ChangeNotifier {
  FileNode get root => _root;
  String get rootPath => _rootPath;

  AutoFindStoragePath autoFindStoragePath;
  FindStoragePath findStoragePath;
  UpdateDirectory updateDirectory;

  late StreamSubscription<Directory> _streamSubscription;

  DirectoryViewModel(
      {required this.autoFindStoragePath,
      required this.findStoragePath,
      required this.updateDirectory}) {
    _streamSubscription = updateDirectory.link().listen(update);
  }

  Future<void> autoFind() async {
    _rootPath = await autoFindStoragePath();
    notifyListeners();
  }

  Future<void> find() async {
    _rootPath = await findStoragePath();
    notifyListeners();
  }

  String _getName(String path) {
    return path.split(Platform.pathSeparator).last;
  }

  FileNode _updateFile(File file) {
    return FileNode(
        isDirectory: false, name: _getName(file.path), isExpanded: false);
  }

  FileNode _updateDirectory(Directory directory) {
    // An algorithm that recycles existing nodes must be added!
    return FileNode(
        isDirectory: true,
        name: _getName(directory.path),
        isExpanded: true,
        children: directory.listSync().map((element) {
          final stat = element.statSync();
          switch (stat.type) {
            case FileSystemEntityType.directory:
              return _updateDirectory(Directory(element.path));
            case FileSystemEntityType.file:
              return _updateFile(File(element.path));
            default:
              break;
          }
          throw UnimplementedError();
        }).toList());
  }

  void update(Directory directory) {
    Logger().d("Update called");
    _root = _updateDirectory(directory);
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  String _rootPath = "";
  FileNode _root =
      FileNode(isExpanded: false, name: "", isDirectory: true, children: []);
  /*
  final _root =
      FileNode(isExpanded: false, name: "_", isDirectory: true, children: [
    FileNode(isExpanded: false, name: "Root", isDirectory: true, children: [
      FileNode(
          isExpanded: false,
          name: "Directory1",
          isDirectory: true,
          children: [
            FileNode(
                isExpanded: false, name: "SubDirectory1", isDirectory: true),
            FileNode(
                isExpanded: false,
                name: "Directory1_File1",
                isDirectory: false),
            FileNode(
                isExpanded: false,
                name: "Directory1_File2",
                isDirectory: false),
          ]),
      FileNode(
          isExpanded: false,
          name: "Directory2",
          isDirectory: true,
          children: [
            FileNode(
                isExpanded: false,
                name: "Directory2_File1",
                isDirectory: false),
            FileNode(
                isExpanded: false,
                name: "Directory2_File2",
                isDirectory: false),
          ]),
      FileNode(isExpanded: false, name: "SubFile1", isDirectory: false),
      FileNode(isExpanded: false, name: "SubFile2", isDirectory: false),
    ]),
    FileNode(isExpanded: false, name: "RootFile1", isDirectory: false),
    FileNode(isExpanded: false, name: "RootFile2", isDirectory: false),
    FileNode(
        isExpanded: false, name: "NewRoot", isDirectory: true, children: [])
  ]);
  */
}
