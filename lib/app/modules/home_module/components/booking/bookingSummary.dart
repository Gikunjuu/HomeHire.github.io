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
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class bookingSummary extends StatefulWidget {
  final String name,
      status,
      gender,
      dob,
      location,
      country,
      category,
      skillLevel,
      yoE,
      salary,
      email,
      hint,
      employerLocation,
      image;
  bookingSummary({
    Key? key,
    required this.name,
    required this.status,
    required this.gender,
    required this.dob,
    required this.location,
    required this.country,
    required this.category,
    required this.skillLevel,
    required this.yoE,
    required this.email,
    required this.salary,
    required this.image,
    required this.hint,
    required this.employerLocation,
  }) : super(key: key);

  @override
  State<bookingSummary> createState() => _bookingSummaryState();
}

class _bookingSummaryState extends State<bookingSummary> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();

  Future<void> startServiceBooking(
      {required String? userPhone, required double amount}) async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone!,
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: "HomeHire Agency",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "Service Booking",
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      /*Update your db with the init data received from initialization response*/
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

  @override
  void initState() {
    super.initState();
    MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
    MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    double commission = double.tryParse(widget.salary) as double;
    double commissionRate = 5 / 100;
    double totalCommission = commission * commissionRate;
    double agencyFee = 100;
    int totalAmount = (agencyFee + totalCommission).ceil();
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
          "Booking Summary",
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
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Service provider details",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 15),
                      bookingUserCard(
                        name: widget.name,
                        location: widget.location,
                        nationality: widget.country,
                        category: widget.category,
                        salary: widget.salary,
                        dateOfBook: widget.skillLevel,
                        status: widget.status,
                        imageUrl: widget.image,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Your details",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.mail,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "${loggedInUser?.email}",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.phone,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "${loggedInUser?.phone}",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.my_location_outlined,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "JX47+5MQ, Nyeri, Kenya",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Booking At",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: <Widget>[
                              Text(
                                DateFormat('dd-MM-yyyy').format(
                                  DateTime.now(),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                DateFormat('KK:mm a').format(
                                  DateTime.now(),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "A hint to the service provider",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.description,
                            color: Colors.black38,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            widget.hint,
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Billing Summary",
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "HomeHire Agency",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      agencyFee.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " Ksh",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Commission as per salary",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Commission percentage",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "5%",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Sub total",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    const Spacer(),
                                    Text(
                                      totalCommission.toString(),
                                      // double.tryParse(widget.salary).toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Divider(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Total Amount",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Row(children: <Widget>[
                                    Text(
                                      totalAmount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(" Ksh",
                                        style:
                                            Theme.of(context).textTheme.caption)
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'NB:\nBy continuing your confirmation, you must pay the above total amount to access contact information to the respective service provicer\nOnly Mpesa payment accepted',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: RoundedButton(
                    text: "Confirm & Book now",
                    press: () {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        startServiceBooking(
                          userPhone: loggedInUser?.phone,
                          amount: totalAmount.toDouble(),
                        );

                        Map<String, dynamic> data = {
                          "serviceProviderName": widget.name,
                          "serviceProviderSalary": widget.salary,
                          "serviceProviderEmail": widget.email,
                          "serviceProviderStatus": widget.status,
                          "serviceProviderGender": widget.gender,
                          "serviceProviderDob": widget.dob,
                          "serviceProviderLocation": widget.location,
                          "serviceProviderNationality": widget.country,
                          "serviceProviderCategory": widget.category,
                          "serviceProviderskillLevel": widget.skillLevel,
                          "serviceProviderYearsOfExperience": widget.yoE,
                          "serviceProviderImageUrl": widget.image,
                          "serviceProviderHint": widget.hint,
                          "employerName": loggedInUser!.name,
                          "employerEmail": loggedInUser!.email,
                          "employerPhone": loggedInUser!.phone,
                          "employerLocation": widget.employerLocation,
                          "bookingTime": DateFormat('dd-MM-yyyy KK:MM a')
                              .format(DateTime.now()),
                          "totalBookingFeePayable": totalAmount.toDouble(),
                        };
                        FirebaseFirestore.instance
                            .collection("bookings")
                            .add(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ApplicationContent()));
                        showTopSnackBar(
                          context,
                          const CustomSnackBar.success(
                            message:
                                "Booking was done successfully\n You can chat or call",
                          ),
                        );
                      } on FirebaseAuthException catch (error) {
                        setState(() {
                          isLoading = false;
                        });
                        switch (error.code) {
                          case "invalid-email":
                            errorMessage =
                                "Your email address appears to be malformed.";

                            break;
                          case "user-not-found":
                            errorMessage =
                                "User with this email doesn't exist.";
                            break;
                          case "user-disabled":
                            errorMessage =
                                "User with this email has been disabled.";
                            break;
                          case "too-many-requests":
                            errorMessage = "Too many requests";
                            break;
                          default:
                            errorMessage = "Please try again later.";
                        }
                        Fluttertoast.showToast(msg: errorMessage!);
                        print(error.code);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
