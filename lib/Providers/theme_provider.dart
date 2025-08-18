import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  ThemeMode get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  toggleTheme(value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}
