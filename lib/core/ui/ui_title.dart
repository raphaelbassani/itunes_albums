import 'package:flutter/material.dart';

class UITitle extends StatelessWidget {
  final String text;
  final Color? color;

  const UITitle(this.text, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    );
  }
}
