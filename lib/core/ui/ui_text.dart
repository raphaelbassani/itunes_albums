import 'package:flutter/material.dart';

class UIText extends StatelessWidget {
  final String text;
  const UIText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'Poppins',
      ),
    );
  }
}
