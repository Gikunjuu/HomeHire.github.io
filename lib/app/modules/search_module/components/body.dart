import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/constants/constants.dart';

class search_body extends StatefulWidget {
  search_body({Key? key}) : super(key: key);

  @override
  State<search_body> createState() => _search_bodyState();
}

class _search_bodyState extends State<search_body> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();
  bool isLoading = false;
  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  navigateToDetailsPage(DocumentSnapshot user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => detailsPage(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  // height: size.height / 20,
                  // width: size.height / 20,
                  child: const SpinKitChasingDots(
                    color: kPrimaryColor,
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  SizedBox(height: size.height / 35),
                  const Text(
                    "Search",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height / 35),
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.2,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: "Search for a user",
                          suffixIcon: IconButton(
                            onPressed: onSearch,
                            icon: const Icon(Icons.search_sharp),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: userMap != null
                        ? ListTile(
                            // onTap: () => print("tapped"),
                            onTap: () => navigateToDetailsPage,
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(userMap!['imageUrl']),
                            ),
                            title: Text(
                              userMap!['name'],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            subtitle: Text(
                              userMap!['email'],
                              style: Theme.of(context).textTheme.caption,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios_sharp),
                          )
                        : Container(),
                  )
                ],
              ),
      ),
    );
  }
}
