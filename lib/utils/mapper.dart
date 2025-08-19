import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  /// Extension for quickly accessing app [ColorScheme]
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Extension for quickly accessing app [TextTheme]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Extension for quickly accessing app [Theme]
  ThemeData get theme => Theme.of(this);

  /// Extension for quickly accessing screen size
  Size get screenSize => MediaQuery.sizeOf(this);
}

extension SizeBoxWidget on num {
  Widget get width => SizedBox(width: double.parse(toString()));
  Widget get height => SizedBox(height: double.parse(toString()));
}
