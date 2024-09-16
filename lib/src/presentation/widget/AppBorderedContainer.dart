import 'package:flutter/material.dart';

class AppBorderedContainer extends StatelessWidget {
  final Widget child;
  const AppBorderedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5), // 내부 여백
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // 테두리 색
          width: 2, // 테두리 두께
        ),
        borderRadius: BorderRadius.circular(10), // 코너를 10pt 둥글게
      ),
      child: child,
    );
  }
}
