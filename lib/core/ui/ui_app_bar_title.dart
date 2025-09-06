import 'package:flutter/material.dart';

class UIAppBarTitle extends StatelessWidget {
  final String text;

  const UIAppBarTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
    );
  }
}
