import 'package:flutter/material.dart';
import '../util/loginForm.dart';

/// Return a string if an error (ex: 'no user'), returns null if no success.
typedef CredentialsCallback = Future<String> Function(
    String email, String password);

String emailValidator(String email) {
  // TODO Validate, will return string if not valid
  return null;
}

String passwordValidator(String password) {
  // TODO Validate, will return string if not valid
  return null;
}

class LoginScreen extends StatefulWidget {
  final CredentialsCallback credentialsCallback;

  LoginScreen({this.credentialsCallback});

  final LoginForm loginForm = new LoginForm(
      emailValidator: emailValidator, passwordValidator: passwordValidator);

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool isPasswordObscure = true;

  void _handleSubmit() {
    String email = widget.loginForm.email.value.text;
    String password = widget.loginForm.password.value.text;
    widget.credentialsCallback(email, password);
  }

  Widget _buildForm() => Form(
        key: widget.loginForm.formKey,
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
        controller: widget.loginForm.email,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(Icons.email),
        ),
      );

  Widget _buildPasswordField() => TextFormField(
        controller: widget.loginForm.password,
        obscureText: isPasswordObscure,
        decoration: InputDecoration(
          labelText: 'Password',
          icon: GestureDetector(
            onTap: () => setState(() => isPasswordObscure = !isPasswordObscure),
            child: (isPasswordObscure)
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }
}
