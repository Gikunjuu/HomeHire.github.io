// import 'package:flutter/material.dart';
// import 'package:home_hire_app/app/modules/utils/bottom_navigation_bar/body.dart';

// class ApplicationContent extends StatelessWidget {
//   const ApplicationContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BottomNavBar(),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/authChecker/admin.dart';
import 'package:home_hire_app/app/modules/utils/bottom_navigation_bar/body.dart';
import 'package:home_hire_app/app/modules/utils/bottom_navigation_bar/bodyAdmin.dart';
import 'package:home_hire_app/app/modules/utils/bottom_navigation_bar/employeeNavBar.dart';
import 'package:home_hire_app/constants/constants.dart';

class ApplicationContent extends StatefulWidget {
  ApplicationContent({Key? key}) : super(key: key);

  @override
  State<ApplicationContent> createState() => _ApplicationContentState();
}

class _ApplicationContentState extends State<ApplicationContent> {
  String? role = 'admin';

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      role = snap['role'];
    });

    if (role == 'admin') {
      navigateNext(AdminBottomNavBar());
    } else if (role == 'user') {
      navigateNext(BottomNavBar());
    } else if (role == 'employee') {
      navigateNext(EmployeeNavBar());
    }
  }

  void navigateNext(Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
