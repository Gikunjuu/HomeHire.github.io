import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/home_module/components/body.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: home_body(),
    );
  }
}
