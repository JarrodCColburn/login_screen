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
  bool _isPasswordVisible = false;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildEmailField(),
            Container(height: 5.0),
            _buildPasswordField(),
            Container( height: 5.0),
            _buildSubmitButton(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );

  Widget _buildSubmitButton() {
      return RaisedButton(
        color: Theme.of(context).primaryColorLight,
        onPressed: _handleSubmit,
        child: Container(
          height: 55,
          child: Center(child: (_isLoading) ? CircularProgressIndicator() :Text('Submit')),
        ),
        shape: OutlineInputBorder(),
      );
    }

  /// email field
  TextFormField _buildEmailField() => TextFormField(
        controller: widget.loginForm.email,
        validator: widget.loginForm.emailValidator,
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          suffixIcon: Icon(
            Icons.email,
          ),
        ),
      );

  /// password field
  Widget _buildPasswordField() => TextFormField(
        controller: widget.loginForm.password,
        validator: widget.loginForm.passwordValidator,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: toggleVisibility,
            child: visibleButton,
          ),
        ),
      );

  Widget get visibleButton => IconButton(
        icon: Icon(
            (_isPasswordVisible) ? Icons.visibility : Icons.visibility_off),
        onPressed: toggleVisibility,
        tooltip: 'Toggle Visibility',
      );

  /// true if keyboard is open
  bool get isKeyboard => MediaQuery.of(context).viewInsets.bottom > 0.0;

  /// if logo provided, show widget when keyboard is closed
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
