import 'package:flutter/material.dart';
import './widget/login_screen.dart';
import './util/auth.dart';

class AuthPage extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child:
          LoginScreen(
            credentialsCallback: Auth.instance.emailSignIn,
          )
      ),
    );
  }
}