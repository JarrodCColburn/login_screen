import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef SuccessCallback = void Function(FirebaseUser user);

class LoginScreen extends StatefulWidget {
  LoginScreen({this.onSuccess});

  final SuccessCallback onSuccess;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool isPasswordObscure = true;

  void _handleSubmit() {
    String email = widget.email.value.text;
    String password = widget.password.value.text;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Widget _buildForm() => Form(
    key: widget.formKey,
    child: Column(
      children: <Widget>[
        _buildEmailField(),
        _buildPasswordField(),
        _buildSubmitButton(),
      ],
    ),
  );

  Widget _buildSubmitButton() => RaisedButton(onPressed: _handleSubmit);

  Widget _buildEmailField() => TextFormField(
    controller: widget.email,
    obscureText: false,
    decoration: InputDecoration(
      labelText: 'Email',
      icon: Icon(Icons.email),
    ),
  );

  Widget _buildPasswordField() => TextFormField(
    controller: widget.password,
    obscureText: isPasswordObscure,
    decoration: InputDecoration(
      labelText: 'Password',
      icon: GestureDetector(
        onTap: ()=> setState(() => isPasswordObscure =! isPasswordObscure),
        child: (isPasswordObscure) ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}