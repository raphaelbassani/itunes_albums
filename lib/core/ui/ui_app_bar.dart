import 'package:flutter/material.dart';

import 'ui_app_bar_title.dart';

class UIAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeading;

  const UIAppBar({this.title = '', this.hasLeading = false, super.key})
    : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<UIAppBar> createState() => _UIAppBarState();

  @override
  final Size preferredSize;
}

class _UIAppBarState extends State<UIAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white10,
      elevation: 0.0,
      title: UIAppBarTitle(widget.title),
      leading: widget.hasLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }
}
