import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/AddUsers_module/components/listAllUsers.dart';

class AddUsers extends StatefulWidget {
  AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListAllUsers(),
    );
  }
}
