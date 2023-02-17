import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/AddUsers_module/components/addEmployee.dart';
import 'package:home_hire_app/app/modules/utils/titleandmorebtn/titleWithMoreBtn.dart';
import 'package:home_hire_app/app/modules/utils/userContainer/userContainer.dart';
import 'package:home_hire_app/app/modules/utils/userContainer/userContainerB.dart';
import 'package:home_hire_app/constants/constants.dart';

class ListAllUsers extends StatefulWidget {
  ListAllUsers({Key? key}) : super(key: key);

  @override
  State<ListAllUsers> createState() => _ListAllUsersState();
}

class _ListAllUsersState extends State<ListAllUsers> {
  late Future _dataEmployees;
  late Future _dataEmployers;
  late Future _dataBookings;

  Future getAllEmployees() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        .where('role', isEqualTo: 'employee')
        .get();
    return qn.docs;
  }

  Future getAllEmployers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        .where('role', isEqualTo: 'user')
        .get();
    return qn.docs;
  }

  Future getAllBookings() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('bookings').get();
    return qn.docs;
  }

  // navigateToDetail(DocumentSnapshot user) {
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
    _dataEmployees = getAllEmployees();
    _dataEmployers = getAllEmployers();
    _dataBookings = getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Admin's panel(crud)",
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Want to add a new employee?",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const Spacer(),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                kBlueColor,
                                kPrimaryColor,
                              ]),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => AddEmployee(),
                              ),
                            );
                          },
                          child: const Text("Add"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: <Widget>[
                  titleWithMoreBtn(
                    title: 'List of all employees',
                    press: () {},
                    btnName: 'See all',
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 250,
                            width: 500,
                            child: FutureBuilder(
                              future: _dataEmployees,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                          imageUrl: snapshot.data[index]
                                              ["imageUrl"],
                                          title: snapshot.data[index]["name"],
                                          nationality: snapshot.data[index]
                                              ["nationality"],
                                          location: snapshot.data[index]
                                              ["location"],
                                          salary: snapshot.data[index]
                                              ["salary"],
                                        ),
                                        // onTap: () =>
                                        // navigateToDetail(snapshot.data[index]),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  titleWithMoreBtn(
                    title: 'List of all Employers',
                    press: () {},
                    btnName: 'See all',
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 250,
                            width: 500,
                            child: FutureBuilder(
                              future: _dataEmployers,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: Text("Loading..."),
                                  );
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (_, index) {
                                      const Text("hey there");
                                      return GestureDetector(
                                        child: userContainerB(
                                          imageUrl: snapshot.data[index]
                                              ["imageUrl"],
                                          title: snapshot.data[index]["name"],
                                          nationality: snapshot.data[index]
                                              ["phone"],
                                          location: snapshot.data[index]
                                              ["email"],
                                        ),
                                        // onTap: () =>
                                        // navigateToDetail(snapshot.data[index]),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  titleWithMoreBtn(
                    title: 'List of all Bookings',
                    press: () {},
                    btnName: 'See all',
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 250,
                            width: 500,
                            child: FutureBuilder(
                              future: _dataBookings,
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: Text("Loading..."),
                                  );
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (_, index) {
                                      const Text("hey there");
                                      return GestureDetector(
                                        child: userContainerB(
                                          imageUrl: snapshot.data[index]
                                              ["imageUrl"],
                                          title: snapshot.data[index]["name"],
                                          nationality: snapshot.data[index]
                                              ["phone"],
                                          location: snapshot.data[index]
                                              ["email"],
                                        ),
                                        // onTap: () =>
                                        // navigateToDetail(snapshot.data[index]),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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


// Container(
                  //   margin: const EdgeInsets.only(top: 30, left: 30),
                  //   decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [
                  //           kBlueColor,
                  //           kPrimaryColor,
                  //         ]),
                  //   ),
                  //   child: Column(
                  //     children: <Widget>[
                  //       const Icon(
                  //         Icons.group_add_outlined,
                  //         size: 70,
                  //         color: Colors.white,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             top: 10, left: 30, right: 30, bottom: 10),
                  //         child: Text(
                  //           "Add an Employee",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .button!
                  //               .copyWith(color: Colors.white),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),