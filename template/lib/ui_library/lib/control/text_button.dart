import 'package:flutter/material.dart';
import 'package:template/ui_library/ui_library.api.dart';

import 'button.dart';

class UITextButton extends StatelessWidget {
  const UITextButton({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return UIButton(
      onPressed: onPressed,
      body: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
