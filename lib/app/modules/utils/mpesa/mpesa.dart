import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/database_firebase/user_model.dart';
import 'package:home_hire_app/app/modules/utils/mpesa/keys.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class mpesa extends StatefulWidget {
  mpesa({Key? key}) : super(key: key);

  @override
  State<mpesa> createState() => _mpesaState();
}

class _mpesaState extends State<mpesa> {
  late DocumentReference paymentsRef;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();

  bool _error = false;

  Future<void> startServiceBooking(
      {required String userPhone, required double amount}) async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: "shoe",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      paymentsRef = FirebaseFirestore.instance
          .collection('payments')
          .doc(loggedInUser?.email);
    } catch (e) {
      print(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
    MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);
    initializeFlutterFire();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("mpesa payment"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              startServiceBooking(
                userPhone: "254798359523",
                amount: 1.0,
              );
            },
            child: const Text("Lipa na Mpesa")),
      ),
    );
  }
}
