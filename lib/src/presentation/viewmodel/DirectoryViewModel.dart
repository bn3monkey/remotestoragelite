import 'package:flutter/material.dart';
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

  DirectoryViewModel(
      {required this.autoFindStoragePath,
      required this.findStoragePath,
      required this.updateDirectory});

  Future<void> autoFind() async {
    _rootPath = await autoFindStoragePath();
    notifyListeners();
  }

  Future<void> find() async {
    _rootPath = await findStoragePath();
    notifyListeners();
  }

  String _rootPath = "C:\\SANS\\PAPYRUS";
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
}
