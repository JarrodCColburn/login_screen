import 'package:flutter/material.dart';
import './widget/login_screen.dart';
import './util/auth.dart';

class AuthPage extends StatelessWidget {
  String title;
  AuthPage({this.logo, this.title});

  final Widget logo;

  List<Widget> get views => [
    Container(child: Center(child: Text('Under Construction'),),),
        LoginScreen(
          credentialsCallback: Auth.instance.emailSignIn,
          logo: logo,
        ),
    Container(child: Center(child: Text('Under Construction'),),)

      ];

  List<Tab> get tabs => [
   Tab( text: "Retrieve",),
   Tab(text: "Login",),
   Tab( text: "Sign Up",)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: views.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(bottom: TabBar(tabs: tabs,), title: Text('Manhole'), centerTitle: true,),
        body: SafeArea(
          child: TabBarView(children: views),
        ),
      ),
    );
  }
}
