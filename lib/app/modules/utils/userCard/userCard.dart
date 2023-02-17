import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

// Users card..

class userCard extends StatelessWidget {
  const userCard({
    Key? key,
    this.itemIndex,
    this.name,
    this.location,
    this.nationality,
    this.salary,
    this.imageUrl,
    this.gender,
  }) : super(key: key);
  final int? itemIndex;
  final String? name;
  final String? location;
  final String? nationality;
  final String? salary;
  final String? imageUrl;
  final String? gender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 160,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: kBlueColor,
              // color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
              boxShadow: [kDefaultShadow],
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 120,
              width: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              width: size.width - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(
                          name!.toUpperCase(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          location!.toUpperCase(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          nationality!.toUpperCase(),
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4),
                    decoration: const BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        )),
                    child: Text(
                      salary!.toLowerCase(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
