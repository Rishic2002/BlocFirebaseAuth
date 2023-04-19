import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_bloc.dart';
import 'login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseAuth = FirebaseAuth.instance;
  runApp(MyApp(firebaseAuth: firebaseAuth));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth firebaseAuth;

  MyApp({required this.firebaseAuth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: BlocProvider(
        create: (context) => AuthBloc(firebaseAuth: firebaseAuth),
        child: LoginPage(),
      ),
    );
  }
}
