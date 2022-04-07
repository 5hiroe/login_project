import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:login_project/common/const.dart';
import 'package:login_project/common/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:login_project/models/user.dart';
import 'dart:convert';

import 'package:login_project/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String errormsg = '';
  String connectedmsg = '';
  bool error = false;
  bool loading = false;
  final mailController = TextEditingController();
  final pwdController = TextEditingController();
  bool signed = true;

  @override
  void dispose() {
    mailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();
      error = false;
      errormsg = '';
      connectedmsg = '';
      mailController.text = '';
      pwdController.text = '';
      signed = !signed;
    });
  }

  startRegister(String mail, String pwd) async {
    String apiurl = "https://shiroe.ddns.net/loginapi/register.php";

    var response = await http
        .post(Uri.parse(apiurl), body: {'mail': mail, 'pwd': pwd});

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata['error']) {
        setState(() {
          loading = false;
          error = true;
          errormsg = jsondata['message'];
        });
      } else {
        if (jsondata['success']) {
          print('success');
          setState(() {
            error = false;
            loading = false;
            connectedmsg = 'Votre compte a bien été créé, vous pouvez vous connecter !';
          });
          String umail = jsondata['mail'];
          print(umail);
        } else {
          loading = false;
          error = true;
          errormsg = "Il y a eu un problème...";
        }
      }
    } else {
      setState(() {
        loading = false;
        error = true;
        errormsg = response.statusCode.toString();
      });
    }
  }

  startLogin(String mail, String pwd) async {
    String apiurl = "https://shiroe.ddns.net/loginapi/login.php";
    print(mailController.text);

    var response = await http
        .post(Uri.parse(apiurl), body: {'mail': mail, 'pwd': pwd});

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata['error']) {
        setState(() {
          loading = false;
          error = true;
          errormsg = jsondata['message'];
        });
      } else {
        if (jsondata['success']) {
          print('success');
          setState(() {
            error = false;
            loading = false;
            connectedmsg = 'Vous êtes connecté ! Bravo !';
          });
          String umail = jsondata['mail'];
          print(umail);
        } else {
          loading = false;
          error = true;
          errormsg = "Il y a eu un problème...";
        }
      }
    } else {
      setState(() {
        loading = false;
        error = true;
        errormsg = "Il y a eu un problème de connexion au serveur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              elevation: 0,
              title: Text(signed ? 'Connexion' : 'Inscription'),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () => toggleView(),
                    icon: const Icon(Icons.person),
                    label: Text(signed ? 'Inscription' : 'Connexion'))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      signed ? 'Connexion' : 'Inscription',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: mailController,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (value) =>
                          value!.isEmpty ? "Entrez votre email" : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: pwdController,
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Mot de Passe'),
                      validator: (value) => value!.length < 6
                          ? "Entrez votre Mot de passe d'au moins 6 caractères"
                          : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        child: Text(
                          signed ? 'Connexion' : 'Inscription',
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            errormsg = '';
                            connectedmsg = '';
                          });
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            var mail = mailController.value.text;
                            var pwd = pwdController.value.text;
                            signed ? startLogin(mail, pwd) : startRegister(mail, pwd);
                          }
                        }),
                    const SizedBox(height: 10),
                    Text(
                      errormsg,
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    Text(
                      connectedmsg,
                      style: const TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold,)
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
