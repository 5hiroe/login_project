import 'package:flutter/material.dart';
import 'package:login_project/common/const.dart';
import 'package:login_project/common/loading.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
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
      error = '';
      mailController.text = '';
      pwdController.text = '';
      signed = !signed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Text(signed ? 'Connexion' : 'Inscription'),
        actions: <Widget>[
          TextButton.icon(onPressed: () => toggleView(),
              icon: const Icon(Icons.person),
              label: Text(signed ? 'Connexion' : 'Inscription'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                TextFormField(
                  controller: mailController,
                  decoration: textInputDecoration.copyWith(hintText:'email'),
                  validator: (value) => value!.isEmpty ? "Entrez votre email" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(hintText:'Mot de Passe'),
                  validator: (value) => value!.length < 6 ? "Entrez votre Mot de passe d'au moins 6 caractères" : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    child: Text(signed ? 'Connexion' : 'Inscription',
                      style: const TextStyle(color:Colors.white),
                    ),
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        var mail = mailController.value.text;
                        var pwd = pwdController.value.text;

                        //TODO Call Firebase

                        dynamic result = null;
                        if (result == null){
                          setState(() {
                            loading = false;
                            error = 'eMail ou Mot de Passe invalide';
                          });
                        }
                      }
                    }),
                const SizedBox(height: 10),
                Text(
                  error,
                  style: const TextStyle(color:Colors.red, fontSize: 15),
                )
              ],
          ),
        ),
      ),
    );
  }
}
