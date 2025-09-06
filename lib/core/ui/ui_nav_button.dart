import 'package:flutter/material.dart';

import 'enums/ui_nav_button_state.dart';

class UINavButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final UINavButtonState state;

  const UINavButton({
    required this.onPressed,
    required this.icon,
    this.state = UINavButtonState.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = 60;
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: state.isEnabled ? Colors.black : Colors.grey,
          shape: const BeveledRectangleBorder(),
          splashFactory: InkRipple.splashFactory,
        ),
        onPressed: state.isEnabled ? onPressed : null,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
