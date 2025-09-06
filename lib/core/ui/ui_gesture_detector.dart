import 'package:flutter/material.dart';

class UIGestureDetector extends StatelessWidget {
  final Function() onTap;
  final Widget child;

  const UIGestureDetector({
    required this.onTap,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(color: Colors.transparent, child: child),
    );
  }
}
