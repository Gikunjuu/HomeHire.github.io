import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/chat_module/body.dart';
import 'package:home_hire_app/app/modules/home_module/body.dart';
import 'package:home_hire_app/app/modules/myBookings_module/body.dart';
import 'package:home_hire_app/app/modules/profile_module/profile_body.dart';
import 'package:home_hire_app/app/modules/search_module/body.dart';
import 'package:home_hire_app/app/modules/AddUsers_module/body.dart';
import 'package:home_hire_app/constants/constants.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    home(),
    myBookings(),
    chat(),
    profile(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        // can comment below line
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        // selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        selectedLabelStyle: const TextStyle(color: kPrimaryColor),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Icon(Icons.book_outlined),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.chat_outlined),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person_outline),
          )
        ],
      ),
    );
  }
}
