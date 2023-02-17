import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_hire_app/app/authentication/forgot_password/body.dart';
import 'package:home_hire_app/app/authentication/sign_up/body.dart';
import 'package:home_hire_app/app/authentication/utils/AccountChecker/AccountChecker.dart';
import 'package:home_hire_app/app/authentication/utils/ForgotPasswordChecker/ForgotPasswordChecker.dart';
import 'package:home_hire_app/app/authentication/utils/background/background.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/app/modules/utils/textFieldContainer/textFieldContainer.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class login_body extends StatefulWidget {
  const login_body({Key? key}) : super(key: key);

  @override
  State<login_body> createState() => _login_bodyState();
}

class _login_bodyState extends State<login_body> {
  // Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  // form key
  final _formKey = GlobalKey<FormState>();
  // To display error messages
  String? errorMessage;
  bool isLoading = false;
  bool isObsecure = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //email field
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
          prefixIcon: Icon(color: kPrimaryColor, Icons.mail),
          hintText: "Email",
          border: InputBorder.none,
        ),
      ),
    );

    //password field
    final passwordField = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: isObsecure,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObsecure = !isObsecure;
              });
            },
            child: Icon(
              isObsecure ? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
          ),
          prefixIcon: const Icon(color: kPrimaryColor, Icons.vpn_key),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );

    // Login btn
    final loginBtn = isLoading
        ? const SpinKitChasingDots(
            color: kPrimaryColor,
          )
        : RoundedButton(
            text: "Sign In",
            press: () {
              signIn(emailController.text, passwordController.text);
            },
          );

    // Forgot password btn
    final forgotPassword = ForgotPasswordChecker(
      press: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Forgotpassword();
        }));
      },
    );

    // SignUp btn
    final signUp = AccountChecker(
      press: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SignupScreen();
        }));
      },
    );

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: const <Widget>[
                          Text(
                            "Hey",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontSize: 40),
                          ),
                          const SizedBox(width: 14),
                          Icon(
                            color: kPrimaryColor,
                            Icons.waving_hand_rounded,
                            size: 40,
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "Welcome Back...",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 40),
                    ),
                    const SizedBox(height: 16),
                    const Text("Sign in to continue",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: kPrimaryColor)),
                    const SizedBox(
                      height: 25,
                    ),

                    // email field
                    emailField,
                    const SizedBox(height: 5),

                    // password field
                    passwordField,
                    const SizedBox(height: 5),

                    // forgot password
                    forgotPassword,
                    const SizedBox(height: 20),

                    // Login btn
                    loginBtn,
                    const SizedBox(height: 30),

                    // Signup btn
                    signUp,
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: email.toLowerCase(), password: password)
            .then((uid) => {
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.success(
                      message: "Welcome to Home Hire!",
                    ),
                  ),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ApplicationContent())),
                });
      } on FirebaseAuthException catch (error) {
        setState(() {
          isLoading = false;
        });
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
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
