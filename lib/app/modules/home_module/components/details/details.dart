import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/bookingScreen.dart';
import 'package:home_hire_app/app/modules/utils/bookingsCard/bookingsCard.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class detailsPage extends StatefulWidget {
  final DocumentSnapshot user;
  detailsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<detailsPage> createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  bool isVisible = false;
  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );
  Widget buildSheet() => makeDismissable(
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
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
                const Text(
                  "Service Booking",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 13),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Column(
                        children: <Widget>[
                          Text(
                            "Personal Details",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      )),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Worker Details",
                              style: Theme.of(context).textTheme.button,
                            ),
                            // Text(
                            //     DateFormat('yyyy-MM-dd').format(DateTime.now()))
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          "Payment Details",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   "To access contact information to " +
                //       widget.user["name"] +
                //       ", Pay the below amount.",
                //   style: const TextStyle(
                //     color: kPrimaryColor,
                //     fontSize: 16,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 13),
                // const Text(
                //   "Ksh. 200",
                //   style: TextStyle(
                //     color: kPrimaryColor,
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 20),
                // RoundedButton(
                //     text: "Lipa na M-pesa",
                //     press: () {
                //       // Navigator.of(context).pushReplacement(
                //       //   MaterialPageRoute(
                //       //     builder: (context) => mpesa(),
                //       //   ),
                //       // );
                //       Navigator.pop(context);
                //       setState(() {
                //         isVisible = !isVisible;
                //       });
                //     })
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    String name = widget.user['name'];
    String status = widget.user['availabilityStatus'];
    String gender = widget.user['gender'];
    String dob = widget.user['dateofbirth'];
    String location = widget.user['location'];
    String country = widget.user['nationality'];
    String email = widget.user['email'];
    String category = widget.user['specialization'];
    String skillLevel = widget.user['skillLevel'];
    String YoE = widget.user['yearsOfExperience'];
    String salary = widget.user['salary'];
    String image = widget.user['imageUrl'];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ApplicationContent(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Back".toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: <Widget>[
          IconButton(
            // onPressed: () => showModalBottomSheet(
            //   // enableDrag: false,
            //   // isDismissible: false,
            //   isScrollControlled: true,
            //   backgroundColor: Colors.transparent,
            //   context: context,
            //   builder: (context) => buildSheet(),
            // ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BookingScreen(
                            category: category,
                            country: country,
                            email: email,
                            gender: gender,
                            location: location,
                            image: image,
                            status: status,
                            salary: salary,
                            dob: dob,
                            name: name,
                            skillLevel: skillLevel,
                            yoE: YoE,
                          )));
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: const Icon(
              Icons.check_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      height: size.width * 0.8,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: size.width * 0.7,
                            width: size.width * 0.7,
                            decoration: const BoxDecoration(
                              color: kBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.network(
                              image,
                              // widget.user["imageUrl"],
                              height: size.width * 0.75,
                              width: size.width * 0.75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.person_outline,
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(width: size.width / 4),
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                            Icons.event_available_outlined),
                                        Text(
                                          status,
                                          // widget.user["availabilityStatus"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.accessibility_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                gender,
                                // widget.user["gender"],
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.date_range_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                dob,
                                // widget.user["dateofbirth"],
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.location_on_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                location +
                                    // widget.user["location"] +
                                    ", " +
                                    country,
                                // widget.user["nationality"],
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.auto_graph_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                category +
                                    // widget.user["specialization"] +
                                    ', ' +
                                    skillLevel,
                                // widget.user["skillLevel"],
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                // widget.user["yearsOfExperience"]
                                YoE + " Years",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.wallet_outlined,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                "Ksh." + salary + "/day",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(children: [
                                  Text(
                                    widget.user["description"],
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(kDefaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Visibility(
                visible: isVisible,
                child: Row(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: widget.user["phone"],
                        );
                        if (await canLaunch(launchUri.toString())) {
                          await launch(launchUri.toString());
                        } else {
                          print("The action is not supported..No phone app");
                        }
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Call",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
