import 'package:flutter/material.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_hire_app/app/modules/home_module/components/categories/categoryA.dart';
import 'package:home_hire_app/app/modules/home_module/components/categories/categoryB.dart';
import 'package:home_hire_app/app/modules/home_module/components/corouselSlider.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/app/modules/utils/titleandmorebtn/titleWithMoreBtn.dart';
import 'package:home_hire_app/app/modules/utils/userContainer/userContainer.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class home_body extends StatefulWidget {
  const home_body({Key? key}) : super(key: key);

  @override
  State<home_body> createState() => _home_bodyState();
}

class _home_bodyState extends State<home_body> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  late Future _dataBS;
  late Future _dataL;

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
            builder: (_) => detailsPage(
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
                                  "Home Hire",
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
              const SizedBox(height: 10),
              titleWithMoreBtn(
                title: 'Services Offered',
                press: () {},
                btnName: 'See all',
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CatergoryAScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/pics/domesticworker1.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                child: Container(
                                  child: Text(
                                    "Laundry",
                                    // servicesImages.values.elementAt(index),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CategoryBScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/pics/domesticworker2.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(height: 15),
                              GestureDetector(
                                child: Container(
                                  child: Text(
                                    "Baby Sitting",
                                    // servicesImages.values.elementAt(index),
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/pics/domesticworker3.jpg"
                                        // "assets/pics/${servicesImages.keys.elementAt(index)}",
                                        ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  "House Keeping",
                                  // servicesImages.values.elementAt(index),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/pics/domesticworker4.jpg"
                                        // "assets/pics/${servicesImages.keys.elementAt(index)}",
                                        ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  "Gardening",
                                  // servicesImages.values.elementAt(index),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/pics/domesticworker1.jpg"
                                        // "assets/pics/${servicesImages.keys.elementAt(index)}",
                                        ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              child: Container(
                                child: Text(
                                  "Pet Cleaning",
                                  // servicesImages.values.elementAt(index),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              titleWithMoreBtn(
                title: 'Laundry category',
                press: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CatergoryAScreen(),
                    ),
                  );
                },
                btnName: 'See all',
              ),
              Container(
                height: 250,
                width: 500,
                child: FutureBuilder(
                  future: _dataL,
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
                              title: snapshot.data[index]["name"],
                              nationality: snapshot.data[index]["nationality"],
                              location: snapshot.data[index]["location"],
                              salary: snapshot.data[index]["salary"],
                            ),
                            onTap: () => navigateToDetail(snapshot.data[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              titleWithMoreBtn(
                title: 'Baby sitting Category',
                press: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoryBScreen(),
                    ),
                  );
                },
                btnName: 'See all',
              ),
              Container(
                height: 250,
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
                              title: snapshot.data[index]["name"],
                              nationality: snapshot.data[index]["nationality"],
                              location: snapshot.data[index]["location"],
                              salary: snapshot.data[index]["salary"],
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
