import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/myBookings_module/components/body.dart';

class myBookings extends StatefulWidget {
  myBookings({Key? key}) : super(key: key);

  @override
  State<myBookings> createState() => _myBookingsState();
}

class _myBookingsState extends State<myBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBooking_body(),
    );
  }
}
