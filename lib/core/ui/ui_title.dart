import 'package:flutter/material.dart';

class UITitle extends StatelessWidget {
  final String text;
  const UITitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    );
  }
}
