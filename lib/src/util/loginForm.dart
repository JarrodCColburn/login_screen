import 'package:flutter/material.dart';
typedef FormTextValidator = String Function(String value);

class LoginForm {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final FormTextValidator emailValidator = (String value){
    if(value.trim().isEmpty){
      return 'Cannot be empty';
    }
  };
  final FormTextValidator passwordValidator = (String value){
    if(value.trim().isEmpty){
      return 'Cannot be empty';
    }
  };

  LoginForm();
}
