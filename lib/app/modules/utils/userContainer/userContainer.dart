import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class userContainer extends StatelessWidget {
  const userContainer(
      {Key? key,
      this.imageUrl,
      this.title,
      this.location,
      this.salary,
      this.press,
      this.nationality})
      : super(key: key);

  final String? imageUrl, title, location, salary, nationality;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            width: 140,
            child: Image.network(
              imageUrl!,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "$title\n".toUpperCase(),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                          color: kPrimaryColor,
                        ),
                      ),
                      TextSpan(
                        text: "$location\n$nationality".toUpperCase(),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: kPrimaryColor.withOpacity(0.8),
                          fontSize: 8,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: size.width * 0.06),
                  Text(
                    "\ksh$salary",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
