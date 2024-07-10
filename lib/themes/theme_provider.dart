import 'package:flutter/material.dart';
import 'package:habittracker_flutter/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // set initial theme to light
  ThemeData _themeData = lightMode;

  // get value of _themeData
  ThemeData get themeData => _themeData;

  // check if current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set the current theme to _themeData by listening to changes.
  set themeData(ThemeData currentThemeData) {
    _themeData = currentThemeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
