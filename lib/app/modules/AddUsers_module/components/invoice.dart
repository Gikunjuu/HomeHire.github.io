import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:home_hire_app/app/modules/AddUsers_module/body.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/mpesa/keys.dart';
import 'package:home_hire_app/app/modules/home_module/components/details/details.dart';
import 'package:home_hire_app/app/modules/utils/bookingsCard/bookingsCard.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_hire_app/pay.dart';

class Invoice extends StatefulWidget {
  String bedValue = 'nodamage';
  String tableValue = 'nodamage';
  String chairValue = 'nodamage';

// Create a variable to store the calculated price
  int price = 0;

// Create a reference to the Firestore database
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Method to calculate the price based on the selected options
  void calculatePrice() {
    price = 0;

    if (bedValue == 'milddamage') {
      price += 400;
    } else if (bedValue == 'severedamage') {
      price += 900;
    }

    if (tableValue == 'milddamage') {
      price += 500;
    } else if (tableValue == 'severedamage') {
      price += 1200;
    }

    if (chairValue == 'milddamage') {
      price += 1000;
    } else if (chairValue == 'severedamage') {
      price += 2000;
    }
  }

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  String bedValue = 'nodamage';
  String tableValue = 'nodamage';
  String chairValue = 'nodamage';

// Create a variable to store the calculated price
  int price = 0;

// Create a reference to the Firestore database
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Method to calculate the price based on the selected options
  void calculatePrice() {
    price = 0;

    if (bedValue == 'milddamage') {
      price += 400;
    } else if (bedValue == 'severedamage') {
      price += 900;
    }

    if (tableValue == 'milddamage') {
      price += 500;
    } else if (tableValue == 'severedamage') {
      price += 1200;
    }

    if (chairValue == 'milddamage') {
      price += 1000;
    } else if (chairValue == 'severedamage') {
      price += 2000;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Generate Invoice",
          style: Theme.of(context).textTheme.button,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// First group of radio buttons
                const Text(
                  "Bed",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),

                RadioListTile(
                  title: const Text(
                      'No Damage                               Ksh 0'),
                  value: 'nodamage',
                  groupValue: bedValue,
                  onChanged: (value) {
                    setState(() {
                      bedValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Mild Damage                               Ksh 400'),
                  value: 'milddamage',
                  groupValue: bedValue,
                  onChanged: (value) {
                    setState(() {
                      bedValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Severe Damage                               Ksh 900'),
                  value: 'severedamage',
                  groupValue: bedValue,
                  onChanged: (value) {
                    setState(() {
                      bedValue = value!;
                      calculatePrice();
                    });
                  },
                ),

                // Second group of radio buttons
                const Text(
                  "Table",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),

                RadioListTile(
                  title: const Text(
                      'No Damage                               Ksh 0'),
                  value: 'nodamage',
                  groupValue: tableValue,
                  onChanged: (value) {
                    setState(() {
                      tableValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Mild Damage                               Ksh 500'),
                  value: 'milddamage',
                  groupValue: tableValue,
                  onChanged: (value) {
                    setState(() {
                      tableValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Severe Damage                               Ksh 1200'),
                  value: 'severedamage',
                  groupValue: tableValue,
                  onChanged: (value) {
                    setState(() {
                      tableValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                const Text(
                  "Chair",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),

                // Third group of radio buttons
                RadioListTile(
                  title: const Text(
                      'No Damage                               Ksh 0'),
                  value: 'nodamage',
                  groupValue: chairValue,
                  onChanged: (value) {
                    setState(() {
                      chairValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Mild Damage                               Ksh 1000'),
                  value: 'milddamage',
                  groupValue: chairValue,
                  onChanged: (value) {
                    setState(() {
                      chairValue = value!;
                      calculatePrice();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text(
                      'Severe Damage                               Ksh 2000'),
                  value: 'severedamage',
                  groupValue: chairValue,
                  onChanged: (value) {
                    setState(() {
                      chairValue = value!;
                      calculatePrice();
                    });
                  },
                ),

                // Display the calculated price
                Text('Total Cost: \Ksh$price'),

                // Button to send the selected options and calculated price to Firestore
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        await firestore.collection('prices').add({
                          'bed': bedValue,
                          'table': tableValue,
                          'chair': chairValue,
                          'price': price,
                        });
                      },
                      child: const Text('Send Invoice to Tenant'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      child: const Text('Initiate Payment'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
