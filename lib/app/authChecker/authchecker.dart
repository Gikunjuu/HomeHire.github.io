import 'package:flutter/material.dart';
import 'package:home_hire_app/app/authentication/sign_in/body.dart';
import 'package:home_hire_app/app/modules/application.dart';

class accountChecker extends StatefulWidget {
  accountChecker({Key? key}) : super(key: key);

  @override
  State<accountChecker> createState() => _accountCheckerState();
}

class _accountCheckerState extends State<accountChecker> {
  // If user is already authenticated, then direct to home_page else login_page
  bool isAuth = false;

  navigateToLogin() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ApplicationContent()));
  }

  Widget authenticated() {
    return navigateToHome();
  }

  Widget notAuthenticated() {
    return navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? authenticated() : notAuthenticated();
  }
}
