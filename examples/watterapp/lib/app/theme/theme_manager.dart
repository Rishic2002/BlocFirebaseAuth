import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class ThemeManager extends ChangeNotifier {
  late bool _isDarkMode;
  late ThemeData _themeData;

  ThemeManager() {
    _isDarkMode = false;
    _themeData = AppTheme().light;
    _loadThemeFromPrefs();
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? AppTheme().dark : AppTheme().light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = _isDarkMode ? AppTheme().dark : AppTheme().light;
    notifyListeners();
  }
}
