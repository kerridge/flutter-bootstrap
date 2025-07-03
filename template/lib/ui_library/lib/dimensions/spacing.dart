import 'package:flutter/material.dart';

enum Spacing {
  xs(2),
  sm(4),
  md(8),
  lg(16),
  xl(24),
  xxl(32),
  xxl2(40),
  xxl3(48),
  xxl4(56),
  xxl5(64),
  xxl6(72);

  const Spacing(this.value);

  final double value;
}

extension SpacingExtension on Spacing {
  EdgeInsets get padding => EdgeInsets.all(value);
}
