import 'package:acv_login_auth/email_google_sigin/pages/loginScreen.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Title(color: Colors.white, child: Text('Login Page')),
          IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: () => Navigator.of(context).pushNamed("/signUp"),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Center(
              child: Text(
            'Login Screen',
            style: TextStyle(fontSize: 30),
          )),
        ),
      ),
    );
  }
}
