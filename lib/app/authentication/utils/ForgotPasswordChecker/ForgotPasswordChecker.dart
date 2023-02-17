import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class ForgotPasswordChecker extends StatelessWidget {
  final bool forgotPassword;
  final VoidCallback press;
  const ForgotPasswordChecker({
    Key? key,
    this.forgotPassword = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Text(
              forgotPassword ? "Forgot Password" : "<-| Login",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
