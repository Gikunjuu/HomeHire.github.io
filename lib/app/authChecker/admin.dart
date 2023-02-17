import 'package:flutter/material.dart';

class adminPage extends StatefulWidget {
  adminPage({Key? key}) : super(key: key);

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("admin page"),
      ),
    );
  }
}
