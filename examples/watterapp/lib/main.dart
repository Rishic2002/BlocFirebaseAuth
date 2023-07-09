import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:watterApp/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'app/theme/theme.dart';
import 'app/theme/theme_manager.dart';
import 'app/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final themeManager = ThemeManager();
  runApp(
    MultiProvider(
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
      child: App(authenticationRepository: authenticationRepository),
    ),
  );
}

// need to be run after flutter clean and before deployement 
// app icon  flutter pub run flutter_launcher_icons:main
// splash screen   flutter pub run flutter_native_splash:create


// login using bloc , key etc 
// created .env file for storing keys, queries and SHOULD BE INGNORED IN GITIGNORE 
// user_id to firebase with society key after login 
// retieve society key after user login


// other way of login without bloc 
// email to firestore cloud + name + phno + key 
// then fetch it after login to display tanks 



// login fix  app need to be restart   flutt
//society name instead of email in homepage 
// profile page +UI adjustments (background color)
// graphs line time graph 
// organize homepage api call
// society key
// user journey 
// graphs line time graph 
// email validation 

