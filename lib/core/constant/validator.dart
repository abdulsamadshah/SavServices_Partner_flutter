import 'package:flutter/cupertino.dart';

class Validator {
  static String? validateEmail(dynamic? value) {
    String patttern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(patttern);
    value = value?.trim();
    if (value == null) {
      return 'Email address cannot be empty';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }


  static String? validateUsername(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'User Name cannot be empty';
    }
    final specialCharacterRegex = RegExp(r'[!@#$%^&*(),?":{}|<>]');
    if (specialCharacterRegex.hasMatch(value)) {
      return 'Please enter a valid User Name';
    }
    return null;
  }






  static FormFieldValidator<String> validate({required String title}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "$title is required";
      }
      return null;
    };
  }
}
