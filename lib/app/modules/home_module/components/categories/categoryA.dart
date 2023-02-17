import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/app/modules/utils/userCard/userCard.dart';
import 'package:home_hire_app/constants/constants.dart';

class CatergoryAScreen extends StatefulWidget {
  CatergoryAScreen({Key? key}) : super(key: key);

  @override
  State<CatergoryAScreen> createState() => _CatergoryAScreenState();
}

class _CatergoryAScreenState extends State<CatergoryAScreen> {
  TextEditingController? _searchController = TextEditingController();
  String? name = '';
  late Future _dataL;
  Future getUsers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('employees')
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
    _dataL = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.34,
            child: Stack(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      // bottom: 36 + kDefaultPadding,
                    ),
                    height: size.height * 0.34 - 20,
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
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.only(left: 3),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ApplicationContent(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Laundry Category",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.local_laundry_service_outlined,
                              size: 100,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: _dataL,
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: SpinKitChasingDots(color: kPrimaryColor),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            if (name!.isEmpty) {
                              return GestureDetector(
                                child: userCard(
                                  imageUrl: snapshot.data[index]["imageUrl"],
                                  name: snapshot.data[index]["name"],
                                  location: snapshot.data[index]["location"],
                                  nationality: snapshot.data[index]
                                      ["nationality"],
                                  salary: snapshot.data[index]["salary"],
                                  gender: snapshot.data[index]["gender"],
                                ),
                                onTap: () =>
                                    navigateToDetail(snapshot.data[index]),
                              );
                            }
                            if (snapshot.data[index]['name']
                                .toString()
                                .startsWith(name!)) {
                              return GestureDetector(
                                child: userCard(
                                  imageUrl: snapshot.data[index]["imageUrl"],
                                  name: snapshot.data[index]["name"],
                                  location: snapshot.data[index]["location"],
                                  nationality: snapshot.data[index]
                                      ["nationality"],
                                  salary: snapshot.data[index]["salary"],
                                  gender: snapshot.data[index]["gender"],
                                ),
                                onTap: () =>
                                    navigateToDetail(snapshot.data[index]),
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
