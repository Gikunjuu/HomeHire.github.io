import 'package:flutter/material.dart';
import 'package:home_hire_app/app/authentication/sign_in/components/body.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: login_body());
  }
}
