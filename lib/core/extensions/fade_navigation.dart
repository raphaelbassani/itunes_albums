import 'package:flutter/material.dart';

extension FadeNavigation on BuildContext {
  Future<T?> pushFade<T>(Widget page) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
