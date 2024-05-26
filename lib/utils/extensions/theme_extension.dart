import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}
