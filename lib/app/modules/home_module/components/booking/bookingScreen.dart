import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/home_module/components/booking/bookingSummary.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String name,
      status,
      gender,
      dob,
      location,
      country,
      category,
      skillLevel,
      yoE,
      email,
      salary,
      image;
  BookingScreen({
    Key? key,
    required this.name,
    required this.status,
    required this.email,
    required this.gender,
    required this.dob,
    required this.location,
    required this.country,
    required this.category,
    required this.skillLevel,
    required this.yoE,
    required this.salary,
    required this.image,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedOption = 1;
  Widget customRadio(Text text, int index) {
    return Container(
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       kBlueColor,
        //       kPrimaryColor,
        //     ]),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedOption = index;
            });
          },
          child: text,
          style: ElevatedButton.styleFrom(
            primary: (selectedOption == index)
                ? kPrimaryColor
                : kPrimaryColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  late TextEditingController hintText = TextEditingController();
  @override
  void initState() {
    hintText = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String loc = "JX47+5MQ, Nyeri, Kenya";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Book the service",
          style: Theme.of(context).textTheme.button,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Your Address",
                          style: Theme.of(context).textTheme.button,
                        ),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  kBlueColor,
                                  kPrimaryColor,
                                ]),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "New",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(width: 7),
                                    const Icon(
                                      Icons.my_location_outlined,
                                      color: Colors.white,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on,
                          color: Colors.black26,
                        ),
                        const SizedBox(width: 18),
                        Text(loc, style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Hint",
                          style: Theme.of(context).textTheme.button,
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      child: TextFormField(
                        maxLines: 2,
                        autofocus: false,
                        controller: hintText,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          hintText.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText:
                              'Is there anything else you would like me to do ?',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                  ],
                ),
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        customRadio(const Text("As soon as possible"), 1),
                        customRadio(const Text("Schedule an order"), 2),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Requested service on",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                          DateTime.now(),
                        ),
                        style: Theme.of(context).textTheme.button,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateFormat('KK:mm a').format(
                          DateTime.now(),
                        ),
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Center(
                  child: RoundedButton(
                    text: "Continue",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => bookingSummary(
                            name: widget.name,
                            email: widget.email,
                            status: widget.status,
                            gender: widget.gender,
                            dob: widget.dob,
                            location: widget.location,
                            country: widget.country,
                            category: widget.category,
                            skillLevel: widget.skillLevel,
                            yoE: widget.yoE,
                            salary: widget.salary,
                            image: widget.image,
                            hint: hintText.text,
                            employerLocation: loc,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
