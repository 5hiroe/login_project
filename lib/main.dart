import 'package:flutter/material.dart';
import 'package:login_project/screens.auth/auth_screen.dart';

void main()=> runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}

