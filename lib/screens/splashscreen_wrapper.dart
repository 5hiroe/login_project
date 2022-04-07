import 'package:flutter/material.dart';
import 'package:login_project/models/user.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    if (user == null) {
      return AuthScreen();
    }else{
      return HomeScreen();
    }
  }
}
