import 'package:flutter/material.dart';
import 'package:telepatia_ai/config/theme/theme.dart';

class AppTheme {
  final bool isDarkMode;
  final BuildContext context;

  AppTheme({required this.context, required this.isDarkMode});

  ThemeData getTheme() {
    final textTheme = MaterialTheme.createTextTheme(context, "Nunito", "Nunito");
    final materialTheme = MaterialTheme(textTheme);

    return isDarkMode ? materialTheme.dark() : materialTheme.light();
  }
}
