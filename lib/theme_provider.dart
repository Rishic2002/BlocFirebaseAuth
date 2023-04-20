import 'package:flutter/material.dart';

import 'theme.dart';


class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({ThemeData? initialThemeData})
      : _themeData = initialThemeData ?? AppTheme().light;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
