import 'package:flutter/material.dart';
import 'package:login_project/screens/auth_screen.dart';
import 'package:login_project/screens/splashscreen_wrapper.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const AuthScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}
