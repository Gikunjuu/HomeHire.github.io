import 'package:flutter/material.dart';
import 'package:home_hire_app/constants/constants.dart';

class bookingUserCard extends StatelessWidget {
  const bookingUserCard({
    Key? key,
    required this.name,
    required this.location,
    required this.nationality,
    required this.category,
    required this.salary,
    required this.dateOfBook,
    required this.status,
    required this.imageUrl,
  }) : super(key: key);

  final String name;
  final String location;
  final String nationality;
  final String category;
  final String salary;
  final String dateOfBook;
  final String status;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: kGreyColor,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 2.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                          const SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              const Icon(Icons.location_on,
                                  size: 14, color: kPrimaryColor),
                              Text(
                                location + ", " + nationality,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        category,
                        style: Theme.of(context).textTheme.button,
                      ),
                      Text(
                        dateOfBook,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ksh." + salary,
                        style: Theme.of(context).textTheme.button,
                      ),
                      Text(
                        status,
                        style: Theme.of(context).textTheme.button,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
