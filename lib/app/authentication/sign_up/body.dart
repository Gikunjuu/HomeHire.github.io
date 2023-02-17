import 'package:flutter/material.dart';
import 'package:home_hire_app/app/authentication/sign_up/components/body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: signUp_body(),
    );
  }
}
