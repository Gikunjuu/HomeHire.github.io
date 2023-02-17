import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0.9),
      // padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2.7),
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
