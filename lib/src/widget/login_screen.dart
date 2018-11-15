import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  void toggleVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  bool _isLoading = false;

  void startLoading() => setState(() => _isLoading = true);

  void endLoading() => setState(() => _isLoading = false);

  void _handleSubmit() {
    bool isValid = widget.loginForm.formKey.currentState.validate();
    if (isValid) {
      String email = widget.loginForm.email.value.text;
      String password = widget.loginForm.password.value.text;
      startLoading();
      widget.credentialsCallback(email, password).whenComplete(endLoading);
    }
  }

  Widget _buildForm(BuildContext context) => Form(
        key: widget.loginForm.formKey,
        child: Column(
          children: <Widget>[
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildSubmitButton(context),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );

  Widget _buildSubmitButton(BuildContext context) => RaisedButton(
        onPressed: _handleSubmit,
        child: (_isLoading) ? CircularProgressIndicator() : Text('Submit'),
        shape: RoundedRectangleBorder(),
      );

  Widget _buildEmailField(BuildContext context) => TextFormField(
        controller: widget.loginForm.email,
        validator: widget.loginForm.emailValidator,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(
            Icons.email,
            color: Theme.of(context).accentColor,
          ),
        ),
      );

  Widget _buildPasswordField(BuildContext context) => TextFormField(
        controller: widget.loginForm.password,
        validator: widget.loginForm.passwordValidator,
        obscureText: _isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          icon: GestureDetector(
            onTap: toggleVisibility,
            child: (_isPasswordVisible)
                ? Icon(
                    Icons.visibility,
                    color: Theme.of(context).accentColor,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Theme.of(context).accentColor,
                  ),
          ),
        ),
      );

  bool isKeyboard(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom <= 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildForm(context),
          (isKeyboard(context))
              ? Container(
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2012/04/01/19/29/tower-24208_960_720.png',
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                )
              : Container()
        ],
      )),
    );
  }
}
