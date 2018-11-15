import 'package:flutter/material.dart';
typedef FormTextValidator = String Function(String value);

class LoginForm {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final FormTextValidator emailValidator;
  final FormTextValidator passwordValidator;

  LoginForm({this.emailValidator, this.passwordValidator});
}
