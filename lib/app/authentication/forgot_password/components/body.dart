import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_hire_app/app/authentication/sign_in/body.dart';
import 'package:home_hire_app/app/authentication/utils/ForgotPasswordChecker/ForgotPasswordChecker.dart';
import 'package:home_hire_app/app/authentication/utils/background/background.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/app/modules/utils/textFieldContainer/textFieldContainer.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class forgot_password_body extends StatefulWidget {
  forgot_password_body({Key? key}) : super(key: key);

  @override
  State<forgot_password_body> createState() => _forgot_password_bodyState();
}

class _forgot_password_bodyState extends State<forgot_password_body> {
  // Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Editing controllers
  late final TextEditingController emailController;
  // form key
  final _formKey = GlobalKey<FormState>();
  // To display error messages
  String? errorMessage;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Email field
    final emailField = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: "Email",
          border: InputBorder.none,
        ),
      ),
    );
    return Background(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Forgot Your \nPassword ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Please enter your email to reset",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: kPrimaryColor)),
                  const SizedBox(height: 20),
                  emailField,
                  const SizedBox(height: 20),
                  RoundedButton(
                    text: "Reset Password",
                    press: resetPassword,
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      ForgotPasswordChecker(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ),
                          );
                        },
                        forgotPassword: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void resetPassword() {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "success!",
          ),
        );
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Please try again later.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
