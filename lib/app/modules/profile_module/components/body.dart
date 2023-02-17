import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/authentication/sign_in/body.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:home_hire_app/constants/constants.dart';

class profile_body extends StatefulWidget {
  profile_body({Key? key}) : super(key: key);

  @override
  State<profile_body> createState() => _profile_bodyState();
}

class _profile_bodyState extends State<profile_body> {
  User? user = FirebaseAuth.instance.currentUser;
  //  change
  UserModel? loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          "My Account",
          style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: Image(
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        loggedInUser?.imageUrl ?? '')),
                              ),
                              const SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Icon(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        Icons.person_outline,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${loggedInUser?.name}",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        Icons.email_outlined,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${loggedInUser?.email}",
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        color: kPrimaryColor.withOpacity(0.5),
                                        Icons.local_phone_outlined,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${loggedInUser?.phone}",
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                                "Role:",
                                style: Theme.of(context).textTheme.button,
                              ),
                              Text(
                                "${loggedInUser?.role}",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.edit_note),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Edit profile",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Account and support",
                            style: Theme.of(context).textTheme.button,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.menu_book_rounded),
                                  const SizedBox(width: 10),
                                  Text(
                                    "How to use HomeHire",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.question_mark_sharp),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Contact HomeHire support team",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.notifications_active),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Notifications",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.my_library_books_rounded),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Terms of service",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.lock_person_rounded),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Privacy policy",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Logins",
                            style: Theme.of(context).textTheme.button,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.logout_rounded),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      logout(context);
                                    },
                                    child: Text(
                                      "Logout",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                      color: kPrimaryColor.withOpacity(0.5),
                                      Icons.delete_rounded),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Delete your account",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.redAccent),
                                  )
                                ],
                              ),
                              Icon(
                                color: kPrimaryColor.withOpacity(0.5),
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "User ID: " + "${loggedInUser?.uid}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 10),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "Version: 1.0.0",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 10),
                              ),
                            ],
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
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }
}
