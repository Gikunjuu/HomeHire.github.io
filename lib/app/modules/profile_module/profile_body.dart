import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/profile_module/components/body.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profile_body(),
    );
  }
}
