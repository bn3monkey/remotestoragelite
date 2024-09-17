import 'package:flutter/material.dart';

class TreeNode<T extends TreeNode<T>> extends ChangeNotifier {
  TreeNode(
      {required bool isExpanded, required bool isExpandable, List<T>? children})
      : _isExpanded = isExpanded,
        _isExpandable = isExpandable,
        _children = children ?? [];

  final bool _isExpandable;
  bool get isExpandable {
    return _isExpandable;
  }

  bool _isExpanded;

  bool get isExpanded => _isExpanded;
  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  final List<T> _children;
  List<T> get children => _children;

  void addTreeNode(T node) {
    children.add(node);
    notifyListeners();
  }

  void removeTreeNode(T node) {
    children.remove(node);
    notifyListeners();
  }

  void cleanChildren() {
    children.clear();
    notifyListeners();
  }

  void changeChildren(List<T> newChildren) {
    cleanChildren();
    children.addAll(newChildren);
    notifyListeners();
  }
}

abstract class TreeNodeContentView<T extends TreeNode<T>>
    extends StatelessWidget {
  final T node;
  const TreeNodeContentView({super.key, required this.node});
}

class TreeNodeView<Node extends TreeNode<Node>,
    NodeContentView extends TreeNodeContentView<Node>> extends StatelessWidget {
  final Node node;
  final NodeContentView Function(Node) contentViewBuilder;

  const TreeNodeView(
      {super.key, required this.node, required this.contentViewBuilder});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: node,
        builder: (context, oldWidget) {
          return Column(
            children: [
              Row(children: [
                IconButton(
                    icon: node.isExpandable
                        ? Icon(node.isExpanded
                            ? Icons.expand_more
                            : Icons.expand_less)
                        : const SizedBox.shrink(),
                    onPressed: node.isExpandable
                        ? () {
                            node.isExpanded = !node.isExpanded;
                          }
                        : null),
                contentViewBuilder(node)
              ]),
              if (node.isExpanded)
                Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                        children: node.children
                            .map((childNode) => TreeNodeView(
                                  node: childNode,
                                  contentViewBuilder: contentViewBuilder,
                                ))
                            .toList()))
            ],
          );
        });
  }
}

class TreeView<Node extends TreeNode<Node>,
    NodeContentView extends TreeNodeContentView<Node>> extends StatelessWidget {
  final Node root;
  final NodeContentView Function(Node) contentViewBuilder;

  const TreeView(
      {super.key, required this.root, required this.contentViewBuilder});

  // @Todo Change Sliverlist for better memory use
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: root,
        builder: (context, child) => SingleChildScrollView(
            child: Column(
                children: root.children
                    .map((node) => TreeNodeView(
                        node: node, contentViewBuilder: contentViewBuilder))
                    .toList())));
  }
}
