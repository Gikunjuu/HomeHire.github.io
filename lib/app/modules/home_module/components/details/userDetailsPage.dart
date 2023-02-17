import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/database_firebase/reviews.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/bookingScreen.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/bookingSummary.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UserDetailsPage extends StatefulWidget {
  final DocumentSnapshot user;

  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isVisible = false;
  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );
  final reviews = FirebaseFirestore.instance.collection('reviews');

  int dataLength = 0;
  final reviewsRef = FirebaseFirestore.instance.collection('reviews');
  getReviewsCount() async {
    QuerySnapshot snapshot =
        await reviewsRef.doc(widget.user['email']).collection('reviews').get();
    setState(() {
      dataLength = snapshot.docs.length;
    });
  }

  int ratingsCount = 0;
  getRatingsCount() async {
    setState(() {
      ratingsCount = 0;
    });
  }

  navigateToBooking() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => bookingSummary(
                  category: widget.user['specialization'],
                  country: widget.user['nationality'],
                  email: widget.user['email'],
                  gender: widget.user['gender'],
                  location: widget.user['location'],
                  image: widget.user['imageUrl'],
                  uid: widget.user['uid'],
                  status: widget.user['availabilityStatus'],
                  salary: widget.user['salary'],
                  dob: widget.user['dateofbirth'],
                  name: widget.user['name'],
                  skillLevel: widget.user['skillLevel'],
                  yoE: widget.user['yearsOfExperience'],
                  employerLocation: '',
                  hint: '',
                )));
  }

  String? _statusAvailability = "Availability";
  _checkStatusAvailability() async {
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user['uid'])
        .get();

    setState(() {
      _statusAvailability = snap['availabilityStatus'];
    });
    if (_statusAvailability == 'Available') {
      navigateToBooking();
    } else if (_statusAvailability == 'Unavailable') {
      // ignore: use_build_context_synchronously
      navigateToBooking();
    }
  }

  @override
  void initState() {
    getReviewsCount();
    getRatingsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = widget.user['name'];
    String status = widget.user['availabilityStatus'];
    String gender = widget.user['gender'];
    String dob = widget.user['dateofbirth'];
    String location = widget.user['location'];
    String uid = widget.user['uid'];
    String country = widget.user['nationality'];
    String email = widget.user['email'];
    String category = widget.user['specialization'];
    String skillLevel = widget.user['skillLevel'];
    String YoE = widget.user['yearsOfExperience'];
    String salary = widget.user['salary'];
    String image = widget.user['imageUrl'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Back",
          style: Theme.of(context).textTheme.button,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: RoundedButton(
            text: "Checkout",
            press: _checkStatusAvailability,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      iconDetails(
                        icon: const Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        press: () {},
                      ),
                      iconDetails(
                        icon: const Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        press: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.width * .8,
                  width: size.width * .75,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: kPrimaryColor.withOpacity(0.29),
                      )
                    ],
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fill,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: name + "\n\n",
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: kTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Ksh. " + salary + " /month",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 2.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "More information",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      widget.user["description"],
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 2.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Ratings & Reviews",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                    const Divider(),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Ratings: ",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                StreamBuilder(
                                  stream: reviews
                                      .doc(email)
                                      .collection('reviews')
                                      .orderBy("reviewedDate", descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SpinKitChasingDots(
                                          color: kPrimaryColor);
                                    }
                                    var ds = snapshot.data!.docs;
                                    double sum = 0.0;
                                    double totalRatingsSum = 0.0;
                                    for (int i = 0; i < ds.length; i++) {
                                      sum += (ds[i]['rating']).toDouble();
                                      totalRatingsSum = (sum / dataLength);
                                    }
                                    return Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: totalRatingsSum,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding:
                                              const EdgeInsets.all(0.2),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber[800],
                                          ),
                                          onRatingUpdate: (double value) {},
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "$totalRatingsSum",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Text(
                      "Reviews ($dataLength)",
                      style: Theme.of(context).textTheme.button,
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder(
                      stream: reviews
                          .doc(email)
                          .collection('reviews')
                          .orderBy("reviewedDate", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SpinKitChasingDots(color: kPrimaryColor);
                        }
                        List<ReviewData> reviewData = [];
                        snapshot.data!.docs.forEach((doc) {
                          reviewData.add(ReviewData.fromDocument(doc));
                        });
                        return ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: reviewData,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

class iconDetails extends StatelessWidget {
  const iconDetails({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      padding: const EdgeInsets.all(kDefaultPadding / 4),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 10,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          const BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 10,
            color: Colors.white,
          ),
        ],
      ),
      child: IconButton(onPressed: press, icon: icon),
    );
  }
}
