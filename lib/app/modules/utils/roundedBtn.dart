import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kBlueColor,
              kPrimaryColor,
            ]),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            style: TextButton.styleFrom(
                // padding:
                // const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                // backgroundColor: kPrimaryColor
                ),
            onPressed: widget.press,
            child: Text(
              widget.text,
              style: TextStyle(color: widget.textColor),
            )),
      ),
    );
  }
}
