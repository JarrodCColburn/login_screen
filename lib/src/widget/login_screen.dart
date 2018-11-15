import 'package:flutter/material.dart';
import '../util/loginForm.dart';

typedef CredentialsCallback = Future<void> Function(
    String email, String password);

class LoginScreen extends StatefulWidget {
  final Widget logo;
  final CredentialsCallback credentialsCallback;

  LoginScreen({this.credentialsCallback, this.logo});

  final LoginForm loginForm = new LoginForm();

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = true;

  void toggleVisibility() =>
      setState(() => _isPasswordVisible = !_isPasswordVisible);

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
        shape: RoundedRectangleBorder(),
      );

  Widget _buildEmailField() => TextFormField(
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

  Widget _buildPasswordField() => TextFormField(
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

  bool get isKeyboard => MediaQuery.of(context).viewInsets.bottom > 0.0;

  Widget get logo => (isKeyboard)
      ? null
      : Container(
          child: widget.logo,
          margin: EdgeInsets.symmetric(horizontal: 40.0),
        );

  List<Widget> get widgets =>
      [_buildForm(), logo]..removeWhere((e) => e == null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      )),
    );
  }
}
