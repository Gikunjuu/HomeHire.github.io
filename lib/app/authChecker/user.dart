import 'package:flutter/material.dart';

class userPage extends StatefulWidget {
  userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("user screen"),
      ),
    );
  }
}
