import 'package:flutter/material.dart';
import 'package:login_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget logged() {
      final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
      if (prefs.getBool('isLogged') == null){
        return AuthScreen();
      } else {
        if (prefs.getBool('isLogged') == true){
          return HomeScreen();
        } else {
          return AuthScreen();
        }
      }
    }
    return logged();
  }
}
