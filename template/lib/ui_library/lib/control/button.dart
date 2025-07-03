import 'package:flutter/material.dart';

class UIButton extends StatelessWidget {
  const UIButton({
    super.key,
    required this.onPressed,
    required this.body,
    this.leading,
    this.trailing,
    this.centerContent = true,
  });

  final VoidCallback onPressed;
  final Widget body;
  final Widget? leading;
  final Widget? trailing;
  final bool centerContent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: centerContent
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (leading != null) leading!,
            body,
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
