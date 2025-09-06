import 'package:flutter/material.dart';

class UISubtitle extends StatelessWidget {
  final String text;
  const UISubtitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        fontFamily: 'Poppins',
      ),
    );
  }
}
