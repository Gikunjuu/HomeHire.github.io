import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class titleWithMoreBtn extends StatelessWidget {
  const titleWithMoreBtn({
    Key? key,
    required this.title,
    required this.press,
    required this.btnName,
  }) : super(key: key);
  final String title, btnName;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          titleWithCustomUnderline(
            text: title,
          ),
          const Spacer(),
          Container(
            height: 35,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kBlueColor,
                    kPrimaryColor,
                  ]),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: press,
              child: Text(btnName),
            ),
          ),
        ],
      ),
    );
  }
}

class titleWithCustomUnderline extends StatelessWidget {
  const titleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: kDefaultPadding / 4),
              height: 3,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
