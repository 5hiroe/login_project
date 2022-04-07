import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text("Appli de fou !"),
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Déconnexion', style: TextStyle(color:Colors.white)),
              onPressed: () async {
              },
          )
        ],
      )
    );
  }
}
