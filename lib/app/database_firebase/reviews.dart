import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:home_hire_app/app/modules/utils/reviewUserCard/reviewUserCard.dart';

class ReviewData extends StatelessWidget {
  String? review;
  String? reviewedByName;
  Timestamp? reviewedDate;
  double? rating;

  ReviewData({
    this.review,
    this.reviewedByName,
    this.reviewedDate,
    this.rating,
  });

  // receiving data from server
  factory ReviewData.fromDocument(DocumentSnapshot doc) {
    return ReviewData(
      review: doc['review'],
      reviewedByName: doc['reviewedByName'],
      reviewedDate: doc['reviewedDate'],
      rating: doc['rating'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'review': review,
      'reviewedByName': reviewedByName,
      'reviewedDate': reviewedDate,
      'rating': rating,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // ClipRRect(
                  //   borderRadius: const BorderRadius.all(Radius.circular(15)),
                  //   child: Image(
                  //     height: 80,
                  //     width: 80,
                  //     fit: BoxFit.fill,
                  //     image: NetworkImage(reviewedByImageUrl!),
                  //   ),
                  // ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        reviewedByName!,
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          RatingBar.builder(
                            initialRating: rating!,
                            // minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: const EdgeInsets.all(0.2),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber[800],
                            ),
                            onRatingUpdate: (ratings) {
                              rating = ratings;
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(" + rating.toString() + ")",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
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
                      review!,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: Row(
                      children: <Widget>[
                        const Spacer(),
                        Text(
                          timeago.format(reviewedDate!.toDate()),
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
