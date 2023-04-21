import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/theme.dart';
import 'package:flutter_firebase_login/theme_manager.dart';
import 'package:flutter_firebase_login/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final themeManager = ThemeManager();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
          value: themeManager), // Use the existing instance of ThemeManager
      ChangeNotifierProxyProvider<ThemeManager, ThemeProvider>(
        create: (_) => ThemeProvider(),
        update: (_, themeManager, themeProvider) {
          themeProvider!.themeData =
              themeManager.isDarkMode ? AppTheme().dark : AppTheme().light;
          return themeProvider;
        },
      ),
    ],
    child: App(authenticationRepository: authenticationRepository)));
  

  
}
