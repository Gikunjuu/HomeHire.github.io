import 'package:flutter/material.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_hire_app/app/modules/home_module/components/categories/categoryA.dart';
import 'package:home_hire_app/app/modules/home_module/components/categories/categoryB.dart';
import 'package:home_hire_app/app/modules/home_module/components/corouselSlider.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/userDetailsPage.dart';
import 'package:home_hire_app/app/modules/utils/titleandmorebtn/titleWithMoreBtn.dart';
import 'package:home_hire_app/app/modules/utils/userContainer/userContainer.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class maisha extends StatefulWidget {
  const maisha({Key? key}) : super(key: key);

  @override
  State<maisha> createState() => _maishaState();
}

class _maishaState extends State<maisha> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  late Future _dataBS;
  late Future _dataL;

  // Stream<List<DocumentSnapshot>> combinedSnapshot(
  //     Stream<QuerySnapshot> data1, Stream<QuerySnapshot> data2) {
  //   return Rx.combinedSnapshot(
  //       data1,
  //       data2,
  //       (QuerySnapshot a, QuerySnapshot b) =>
  //           List.from(a.docs)..addAll(b.docs));
  // }

  Future getUsers_Baby_sitting() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        .where("specialization", isEqualTo: "Baby sitting")
        .get();
    return qn.docs;
  }

  Future getUsers_Laundry() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        .where("specialization", isEqualTo: "Laundry")
        .get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => UserDetailsPage(
                  user: user,
                )));
  }

  @override
  void initState() {
    super.initState();
    _dataBS = getUsers_Baby_sitting();
    _dataL = getUsers_Laundry();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: size.height * 0.45,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.45 - 24,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              kBlueColor,
                              kPrimaryColor,
                            ]),
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                    ),
                    Positioned(
                        child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 50, left: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.eco,
                                color: kBackgroundColor,
                              ),
                              SizedBox(width: size.width * 0.04),
                              Shimmer.fromColors(
                                baseColor: kBackgroundColor,
                                highlightColor: Colors.grey[500]!,
                                period: const Duration(seconds: 5),
                                child: const Text(
                                  "Dekut Checkout System",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => MyProfile()));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          loggedInUser?.imageUrl ?? ''),
                                    ),
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 190,
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(left: 20),
                          child: const corouselSlider(),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: size.height / 30),
              Container(
                height: 310,
                width: 500,
                child: FutureBuilder(
                  future: _dataBS,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            child: userContainer(
                              imageUrl: snapshot.data[index]["imageUrl"],
                              name: snapshot.data[index]["name"],
                              salary: snapshot.data[index]["salary"],
                              totalRatings: snapshot.data[index]["ratings"],
                            ),
                            onTap: () => navigateToDetail(snapshot.data[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
