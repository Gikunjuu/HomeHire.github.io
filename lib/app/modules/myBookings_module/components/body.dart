import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/ChatDetailPage.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/ChatUsersList.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/app/modules/utils/bookingsCard/bookingsCard.dart';
import 'package:home_hire_app/constants/constants.dart';

class myBooking_body extends StatefulWidget {
  myBooking_body({Key? key}) : super(key: key);

  @override
  State<myBooking_body> createState() => _myBooking_bodyState();
}

class _myBooking_bodyState extends State<myBooking_body> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();

  TextEditingController? _searchController = TextEditingController();
  String? name = '';

  late Future _bookingData;
  var emailIdentifier = FirebaseAuth.instance.currentUser!.email;
  Future getUsersBookings() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('bookings')
        .where("employerEmail", isEqualTo: "$emailIdentifier")
        .get();
    return qn.docs;
  }

  // navigateToDetailsPage(DocumentSnapshot user) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (_) => detailsPage(
  //                 user: user,
  //               )));
  // }

  @override
  void initState() {
    super.initState();
    _bookingData = getUsersBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          "My Bookings",
          style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: _bookingData,
                builder: (_, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: SpinKitChasingDots(color: kPrimaryColor),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            if (name!.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  // navigateToDetailsPage(snapshot.data[index]);
                                },
                                child: bookingUserCard(
                                  name: snapshot.data[index]
                                      ["serviceProviderName"],
                                  location: snapshot.data[index]
                                      ["serviceProviderLocation"],
                                  nationality: snapshot.data[index]
                                      ["serviceProviderNationality"],
                                  category: snapshot.data[index]
                                      ["serviceProviderCategory"],
                                  salary: snapshot.data[index]
                                      ["serviceProviderSalary"],
                                  dateOfBook: snapshot.data[index]
                                      ["bookingTime"],
                                  status: snapshot.data[index]
                                      ["serviceProviderStatus"],
                                  imageUrl: snapshot.data[index]
                                      ["serviceProviderImageUrl"],
                                ),
                              );
                            }
                            if (snapshot.data[index]['serviceProviderName']
                                .toString()
                                .startsWith(name!)) {
                              return GestureDetector(
                                onTap: () {
                                  // navigateToDetailsPage(snapshot.data[index]);
                                },
                                child: bookingUserCard(
                                  name: snapshot.data[index]
                                      ["serviceProviderName"],
                                  location: snapshot.data[index]
                                      ["serviceProviderLocation"],
                                  nationality: snapshot.data[index]
                                      ["serviceProviderNationality"],
                                  category: snapshot.data[index]
                                      ["serviceProviderCategory"],
                                  salary: snapshot.data[index]
                                      ["serviceProviderSalary"],
                                  dateOfBook: snapshot.data[index]
                                      ["bookingTime"],
                                  status: snapshot.data[index]
                                      ["serviceProviderStatus"],
                                  imageUrl: snapshot.data[index]
                                      ["serviceProviderImageUrl"],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
