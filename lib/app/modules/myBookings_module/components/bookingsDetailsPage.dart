import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_hire_app/app/database_firebase/UserModelAdmin.dart';
import 'package:home_hire_app/app/database_firebase/reviews.dart';
import 'package:home_hire_app/app/database_firebase/reviews.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/bookingScreen.dart';
import 'package:home_hire_app/app/modules/utils/reviewUserCard/reviewUserCard.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home_module/components/details/userDetailsPage.dart';

class BookingsUserDetailsPage extends StatefulWidget {
  final DocumentSnapshot user;

  const BookingsUserDetailsPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<BookingsUserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<BookingsUserDetailsPage> {
  bool isVisible = false;
  final _rateReviewKey = GlobalKey<FormState>();

  late final TextEditingController reviewController;
  TextEditingController ratingController = TextEditingController();
  double userRatings = 1.0;

  callFunc() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: widget.user["employerPhone"],
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      print("The action is not supported..No phone app");
    }
  }

  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );
  Widget buildSheet() => makeDismissable(
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Rate & Review: " + widget.user["serviceProviderName"],
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Star Rating",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          child: Column(
                            children: <Widget>[
                              RatingBar.builder(
                                  initialRating: 1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.all(4.0),
                                  itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber[800],
                                      ),
                                  onRatingUpdate: (rating) {
                                    userRatings = rating;
                                    setState(() {});
                                    // print(rating);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Review",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 0.9,
                                ),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextField(
                                  controller: reviewController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type in a review...",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          child: RoundedButton(
                            press: addReview,
                            text: "Review",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  final reviews = FirebaseFirestore.instance.collection('reviews');
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();

  update() {
    final firestore = FirebaseFirestore.instance.collection('users');
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    String email = "janedoe@gmail.com";
    ref.doc(email).update({
      'ratings': 3.5,
    }).then((value) {
      print("successfully updated");
    }).onError((error, stackTrace) {
      print("error occured!!!");
    });
  }

  addReview() {
    reviews.doc(widget.user['serviceProviderEmail']).collection('reviews').add(
      {
        "reviewedByName": loggedInUser?.name,
        "reviewedDate": DateTime.now(),
        "review": reviewController.text,
        "rating": userRatings,
      },
    );
    final firestore = FirebaseFirestore.instance.collection('users');
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(widget.user['uid']).update({
      'ratings': userRatings,
    }).then((value) {
      print("successfully updated");
    }).onError((error, stackTrace) {
      print("error occured!!!");
    });
    reviewController.clear();
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Review done.",
      ),
    );
    Navigator.pop(context);
  }

  getRatingsTotal() {
    return StreamBuilder(
      stream: reviews
          .doc(widget.user['serviceProviderEmail'])
          .collection('reviews')
          .orderBy("reviewedDate", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SpinKitChasingDots(color: kPrimaryColor);
        }
        var ds = snapshot.data!.docs;
        double totalRatingsSum = 0.0;
        double sum = 0.0;
        for (int i = 0; i < ds.length; i++) {
          sum += (ds[i]['rating']).toDouble();
          totalRatingsSum = (sum / dataLength);
        }
        return Row(
          children: [
            Text("Ratings total is: $sum"),
          ],
        );
        // List<ReviewData> reviewData = [];
        // snapshot.data!.docs.forEach((doc) {
        //   reviewData.add(ReviewData.fromDocument(doc));
        // });
        // return Flexible(
        //   child: ListView(
        //     children: reviewData,
        //   ),
        // );
      },
    );
  }

  final reviewsRef = FirebaseFirestore.instance.collection('reviews');
  int dataLength = 0;
  getReviewsCount() async {
    QuerySnapshot snapshot = await reviewsRef
        .doc(widget.user['serviceProviderEmail'])
        .collection('reviews')
        .get();
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
            builder: (_) => BookingScreen(
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
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Already booked, please browse for another worker.",
        ),
      );
    }
  }

  @override
  void initState() {
    reviewController = TextEditingController();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    getReviewsCount();
    getRatingsCount();
    getRatingsTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = widget.user['serviceProviderName'];
    String status = widget.user['serviceProviderStatus'];
    String gender = widget.user['serviceProviderGender'];
    String dob = widget.user['serviceProviderDob'];
    String location = widget.user['serviceProviderLocation'];
    String email = widget.user['serviceProviderEmail'];
    String category = widget.user['serviceProviderCategory'];
    String skillLevel = widget.user['serviceProviderskillLevel'];
    String YoE = widget.user['serviceProviderYearsOfExperience'];
    String salary = widget.user['serviceProviderSalary'];
    String uid = widget.user['uid'];
    String image = widget.user['serviceProviderImageUrl'];

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
                        press: callFunc,
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
                ],
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
                child: Column(),
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
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Ratings & Reviews",
                            style: Theme.of(context).textTheme.button,
                          ),
                          const Spacer(),
                          Text(
                            "Add a review",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          IconButton(
                            onPressed: () => showModalBottomSheet(
                              enableDrag: false,
                              isDismissible: false,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => buildSheet(),
                            ),
                            icon: const Icon(Icons.rate_review),
                            color: kPrimaryColor,
                          )
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
                                  // RatingBar.builder(
                                  //   initialRating: 3,
                                  //   direction: Axis.horizontal,
                                  //   allowHalfRating: true,
                                  //   itemCount: 5,
                                  //   itemSize: 20,
                                  //   itemPadding: const EdgeInsets.all(0.2),
                                  //   itemBuilder: (context, _) => Icon(
                                  //     Icons.star,
                                  //     color: Colors.amber[800],
                                  //   ),
                                  //   onRatingUpdate: (double value) {},
                                  // ),
                                  // const SizedBox(width: 4),
                                  StreamBuilder(
                                    stream: reviews
                                        .doc(
                                            widget.user['serviceProviderEmail'])
                                        .collection('reviews')
                                        .orderBy("reviewedDate",
                                            descending: true)
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                            .doc(widget.user['serviceProviderEmail'])
                            .collection('reviews')
                            .orderBy("reviewedDate", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SpinKitChasingDots(
                                color: kPrimaryColor);
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            const SizedBox(height: 10),
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
