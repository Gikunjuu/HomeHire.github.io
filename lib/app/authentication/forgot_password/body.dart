import 'package:flutter/material.dart';
import 'package:home_hire_app/app/authentication/forgot_password/components/body.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forgot_password_body(),
    );
  }
}
