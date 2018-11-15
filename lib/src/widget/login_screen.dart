import 'package:flutter/material.dart';
import '../util/loginForm.dart';

typedef CredentialsCallback = Future<void> Function(
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

  final LoginForm loginForm = new LoginForm();

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = true;
  void toggleVisibility(){
    setState(() {
     _isPasswordVisible =! _isPasswordVisible;
    });
  }

  bool _isLoading = false;
  void startLoading()=> setState(() => _isLoading = true);
  void endLoading()=> setState(() => _isLoading = false);

  void _handleSubmit() {
    bool isValid = widget.loginForm.formKey.currentState.validate();
    if (isValid) {
      String email = widget.loginForm.email.value.text;
      String password = widget.loginForm.password.value.text;
      startLoading();
      widget.credentialsCallback(email, password).whenComplete(endLoading);
    }
  }

  Widget _buildForm() => Form(
        key: widget.loginForm.formKey,
        child: Column(
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildSubmitButton(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );

  Widget _buildSubmitButton() => RaisedButton(
        onPressed: _handleSubmit,
        child: (_isLoading) ? CircularProgressIndicator() : Text('Submit'),
      );

  Widget _buildEmailField() => TextFormField(
        controller: widget.loginForm.email,
        validator: widget.loginForm.emailValidator,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(Icons.email),
        ),
      );

  Widget _buildPasswordField() => TextFormField(
        controller: widget.loginForm.password,
        validator: widget.loginForm.passwordValidator,
        obscureText: _isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          icon: GestureDetector(
            onTap: toggleVisibility,
            child: (_isPasswordVisible)
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: _buildForm()));
  }
}
