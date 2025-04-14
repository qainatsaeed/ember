import 'package:flutter/material.dart';

import '../screens/setup_screens/login.dart';
import '../utils/utils.dart';

class SignupController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onContinue(BuildContext context) {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    if (username.isEmpty) {
      showCustomDialog(
        context,
        title: 'Username Required',
        description: 'Please enter a username to continue.',
      );
      return;
    } else if (email.isEmpty) {
      showCustomDialog(
        context,
        title: 'Email Required',
        description: 'Please enter an email to continue.',
      );
      return;
    } else if (!isEmailValid(email)) {
      showCustomDialog(
        context,
        title: 'Invalid Email',
        description: 'Please enter a valid email to continue.',
      );
      return;
    } else if (password.isEmpty) {
      showCustomDialog(
        context,
        title: 'Password Required',
        description: 'Please enter a password to continue.',
      );
      return;
    }
    // Navigator.of(context).pushNamed('/signup');
  }

  void onAlreadyHaveAccount(BuildContext context) {
    Navigator.of(context).pushNamed(Login.route);
  }

  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
