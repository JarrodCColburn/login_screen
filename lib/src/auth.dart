import 'package:flutter/material.dart';
import './widget/login_screen.dart';
import './util/auth.dart';

class AuthPage extends StatefulWidget {
  final String title;

  AuthPage({this.logo, this.title});

  final Widget logo;

  @override
  AuthPageState createState() {
    return new AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  List<Widget> views(BuildContext context) => [
        Container(
          child: Center(
            child: Text('Under Construction'),
          ),
        ),
        LoginScreen(
          credentialsCallback: (String email, String password) async {
            return await Auth.instance
                .emailSignIn(
              email,
              password,
            )
                .then((SignInStatus status) {
              print('done');
              switch (status) {
                case SignInStatus.invalid:
                  {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(duration: Duration(seconds: 1),content: Text('Invalid Credentials.',textAlign: TextAlign.center,)));
                  }
                  break;
              }
            });
          },
          logo: widget.logo,
        ),
        Container(
          child: Center(
            child: Text('In Beta, invite only'),
          ),
        )
      ];

  List<Tab> get tabs =>
      [Tab(text: "Retrieve"), Tab(text: "Login"), Tab(text: "Sign Up")];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: tabs,
          ),
          title: Text('Manhole'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext context) => SafeArea(
                child: TabBarView(children: views(context)),
              ),
        ),
      ),
    );
  }
}
