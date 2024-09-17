import 'package:flutter/material.dart';
import 'package:remotestoragelite/src/presentation/widget/AppTreeView.dart';

class FileNode extends TreeNode<FileNode> {
  FileNode({
    required super.isExpanded,
    required String name,
    required bool isDirectory,
    super.children,
  })  : _name = name,
        _isDirectory = isDirectory,
        super(isExpandable: isDirectory) {
    print("sans => isExpandable : $isExpandable isExpanded : $isExpanded");
  }

  String _name;
  bool _isDirectory;

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  bool get isDirectory => _isDirectory;
  set isDirectory(bool value) {
    _isDirectory = value;
    notifyListeners();
  }
}

class FileNodeContentView extends TreeNodeContentView<FileNode> {
  const FileNodeContentView({super.key, required super.node});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(node._isDirectory ? Icons.folder : Icons.description),
        const SizedBox(width: 10.0),
        Text(node.name,
            style: TextStyle(
                fontSize: 15.0,
                color: Theme.of(context).colorScheme.onPrimaryContainer))
      ],
    );
  }
}

class FileTreeView extends StatelessWidget {
  final FileNode root;
  const FileTreeView({super.key, required this.root});

  @override
  Widget build(BuildContext context) {
    return TreeView<FileNode, FileNodeContentView>(
      root: root,
      contentViewBuilder: (node) => FileNodeContentView(node: node),
    );
  }
}
