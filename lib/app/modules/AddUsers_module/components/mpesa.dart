import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double price = 0;

  @override
  void initState() {
    super.initState();
    // fetch price from Firestore
    FirebaseFirestore.instance
        .collection("prices")
        .doc("price")
        .get()
        .then((value) {
      setState(() {
        price = value.data()!["price"].toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Price to pay: KES $price',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // make payment logic
          },
          child: Text('Make Payment'),
        ),
      ],
    );
  }
}
