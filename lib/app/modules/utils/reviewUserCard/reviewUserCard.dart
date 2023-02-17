import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class ReviewUserCard extends StatelessWidget {
  const ReviewUserCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.review,
    required this.date,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String review;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image(
                  height: 80,
                  width: 80,
                  fit: BoxFit.fill,
                  image: NetworkImage(imageUrl),
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.button,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Nairobi, Kenya",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  review,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                child: Row(
                  children: <Widget>[
                    const Spacer(),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
