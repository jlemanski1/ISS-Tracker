import 'package:flutter/material.dart';

enum AppTheme {
  LightBlue, DarkBlue
}

// Returns enum value name without enum class name
String enumName(AppTheme selection) {
  return selection.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.LightBlue : ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue,
  ),
  AppTheme.DarkBlue : ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
  ),
};