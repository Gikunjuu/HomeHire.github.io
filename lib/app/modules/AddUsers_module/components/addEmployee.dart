import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_hire_app/app/database_firebase/UserModelAdmin.dart';
import 'package:home_hire_app/app/modules/application.dart';
import 'package:home_hire_app/app/modules/home_module/components/categories/categoryB.dart';
import 'package:home_hire_app/app/modules/utils/bottom_navigation_bar/bodyAdmin.dart';
import 'package:home_hire_app/app/modules/utils/roundedBtn.dart';
import 'package:home_hire_app/app/modules/utils/textFieldContainer/textFieldContainer.dart';
import 'package:home_hire_app/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  // Firebase Authentication
  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;
  // Form key
  final _formKey = GlobalKey<FormState>();
  // Editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  late final TextEditingController locationController;
  late final TextEditingController specializationController;
  late final TextEditingController skilllevelController;
  late final TextEditingController yearsOfExperienceController;
  late final TextEditingController idNumberController;
  late final TextEditingController addressController;
  late final TextEditingController dateOfBirthController;
  late final TextEditingController descriptionController;
  late final TextEditingController nationalityController;
  late final TextEditingController salaryController;
  late final TextEditingController refereeNameController;
  late final TextEditingController refereePhoneNumberController;
  late final TextEditingController availabilityStatusController;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    genderController = TextEditingController();
    locationController = TextEditingController();
    specializationController = TextEditingController();
    skilllevelController = TextEditingController();
    yearsOfExperienceController = TextEditingController();
    idNumberController = TextEditingController();
    addressController = TextEditingController();
    dateOfBirthController = TextEditingController();
    descriptionController = TextEditingController();
    nationalityController = TextEditingController();
    salaryController = TextEditingController();
    refereeNameController = TextEditingController();
    refereePhoneNumberController = TextEditingController();
    availabilityStatusController = TextEditingController();

    super.initState();
  }

  static const genderValues = <String>['Male', 'Female', 'Others'];
  String selectedGenderValue = genderValues.first;

  File? imagePath;

  // pick an image from the camera
  Future _pickImageCamera() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 100, maxWidth: 100);
    if (file != null) {
      imagePath = File(file.path);
      setState(() {
        imagePath = File(file.path);
      });
    }
  }

// pick an image from the gallery
  Future _pickImageGallery() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
    if (file != null) {
      imagePath = File(file.path);
      setState(() {
        imagePath = File(file.path);
      });
    }
  }

// remove the image
  void _removeImage() {
    setState(() {
      imagePath = null;
    });
    Navigator.pop(context);
  }

  uploadImage() {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () => selectImage(context),
          child: const Text(
            "Upload a pic",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Upload a pic"),
          children: [
            SimpleDialogOption(
              child: Text("Image from camera"),
              onPressed: _pickImageCamera,
            ),
            SimpleDialogOption(
              child: Text("Image from gallery"),
              onPressed: _pickImageGallery,
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: _removeImage,
            )
          ],
        );
      },
    );
  }

  String gender = "male";
  String skillLevel = 'Professional';
  String specializeIn = 'Laundry';
  String availabilityStatus = "Available";
  @override
  Widget build(BuildContext context) {
    // name field
    final fullName = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            hintText: "Full Name",
            border: InputBorder.none),
      ),
    );

    // Phone field
    final phoneNo = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          RegExp regex =
              RegExp(r'^[+]*[()]{0,1}[0-9]{1,4}[(]{0,1}[-\s\./0-9]+$');
          if (value!.isEmpty) {
            return ("Phone Number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid phone number");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.phone),
            hintText: "Phone Number",
            border: InputBorder.none),
      ),
    );

    //email field
    final emailField = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: "Email",
          border: InputBorder.none,
        ),
      ),
    );

    //password field
    bool isHiddenPassword = true;
    showPassword() {
      setState(() {
        isHiddenPassword = !isHiddenPassword;
      });
    }

    final passwordField = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: isHiddenPassword,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for sign up");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            hintText: "Password",
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: showPassword,
              icon: Icon(Icons.visibility),
            )),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: confirmPasswordController,
        obscureText: isHiddenPassword,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Password is required for sign up");
          }
          if (confirmPasswordController.text != passwordController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: showPassword,
              icon: Icon(Icons.visibility),
            )),
      ),
    );

    // gender radio btn
    Widget genderRadioBtn = Column(
      children: [
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Male"),
          value: "male",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Female"),
          value: "female",
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              gender = value.toString();
            });
          },
        ),
      ],
    );

// date of birth field
    final dateOfBirth = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: dateOfBirthController,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Date cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          dateOfBirthController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.calendar_month),
          hintText: "Date of Birth",
          border: InputBorder.none,
        ),
      ),
    );

//  nationality field
    final nationality = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: nationalityController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Nationality cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid nationality(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nationalityController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.flag),
          hintText: "Nationality. eg Kenyan",
          border: InputBorder.none,
        ),
      ),
    );

// location field
    final location = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: locationController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Location cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid location(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          locationController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on_outlined),
            hintText: "Town/City",
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {},
              // onPressed: pickCurrentLocation,
              icon: Icon(Icons.my_location),
            )),
      ),
    );

//  address field
    final address = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: addressController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Address cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid address(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          addressController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.contact_phone_sharp),
          hintText: "Postal Address",
          border: InputBorder.none,
        ),
      ),
    );

    // idnumber field
    final idNumber = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: idNumberController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{8,}$');
          if (value!.isEmpty) {
            return ("ID Number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid ID Number(Min. 8 Character)");
          }
          return null;
        },
        onSaved: (value) {
          idNumberController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.contact_phone_sharp),
          hintText: "National ID/Passport/Licence Number",
          border: InputBorder.none,
        ),
      ),
    );

    // skill level radiobtn
    Widget skillLevelRadioBtn = Column(
      children: [
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Professional"),
          value: "Professional",
          groupValue: skillLevel,
          onChanged: (value) {
            setState(() {
              skillLevel = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Apprentice"),
          value: "Apprentice",
          groupValue: skillLevel,
          onChanged: (value) {
            setState(() {
              skillLevel = value.toString();
            });
          },
        ),
      ],
    );

    // availability status
    Widget status = Column(
      children: [
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Available"),
          value: "Available",
          groupValue: availabilityStatus,
          onChanged: (value) {
            setState(() {
              availabilityStatus = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Not Available"),
          value: "Not Available",
          groupValue: availabilityStatus,
          onChanged: (value) {
            setState(() {
              availabilityStatus = value.toString();
            });
          },
        ),
      ],
    );

    // yrs of experience field
    final yearsOfExperience = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: yearsOfExperienceController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Years Of Experience cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          yearsOfExperienceController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.date_range),
          hintText: "Years Of Experience",
          border: InputBorder.none,
        ),
      ),
    );

    // specialization radiobtn
    Widget specialization = Column(
      children: [
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Laundry"),
          value: "Laundry",
          groupValue: specializeIn,
          onChanged: (value) {
            setState(() {
              specializeIn = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Pet Cleaning"),
          value: "Pet Cleaning",
          groupValue: specializeIn,
          onChanged: (value) {
            setState(() {
              specializeIn = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Gardening"),
          value: "Gardening",
          groupValue: specializeIn,
          onChanged: (value) {
            setState(() {
              specializeIn = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Baby sitting"),
          value: "Baby sitting",
          groupValue: specializeIn,
          onChanged: (value) {
            setState(() {
              specializeIn = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Home keeping"),
          value: "Home keeping",
          groupValue: specializeIn,
          onChanged: (value) {
            setState(() {
              specializeIn = value.toString();
            });
          },
        ),
      ],
    );

    final description = TextFieldContainer(
      child: TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        autofocus: false,
        controller: descriptionController,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Description cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Description(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          descriptionController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.description),
          hintText: "More about yourself..",
          border: InputBorder.none,
        ),
      ),
    );

// salary field
    final salary = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: salaryController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Expected salary cannot be Empty");
          }
          if (value.length > 4) {
            return ("Enter Valid Expected salary(Max. 4 Character)");
          }
          return null;
        },
        onSaved: (value) {
          salaryController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.wallet),
          hintText: "Expected salary (ksh) / day",
          border: InputBorder.none,
        ),
      ),
    );

    // referee name
    final refereeName = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: refereeNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Referee name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Referee name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          refereeNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: "Referee name",
          border: InputBorder.none,
        ),
      ),
    );

    // referee phone number
    final refereePhoneNo = TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: refereePhoneNumberController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          RegExp regex =
              new RegExp(r'^[+]*[()]{0,1}[0-9]{1,4}[(]{0,1}[-\s\./0-9]+$');
          if (value!.isEmpty) {
            return ("Referee phone number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid referee phone number(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          refereePhoneNumberController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone_sharp),
          hintText: "Referee phone number",
          border: InputBorder.none,
        ),
      ),
    );

    // Signup btn
    final signUpBtn = isLoading
        ? const SpinKitChasingDots(
            color: kPrimaryColor,
          )
        : RoundedButton(
            text: "Create Worker",
            press: () {
              signUp(emailController.text, idNumberController.text);
            },
          );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ApplicationContent(),
              ),
            );
          },
        ),
        title: Text(
          "Add an Employee",
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.black),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const Text(
                        "Fill in the required details",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: kPrimaryColor),
                      ),
                      Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        kBlueColor,
                                        kPrimaryColor,
                                      ],
                                    ),
                                  ),
                                  child: (imagePath != null)
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.file(
                                            imagePath!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 90,
                            left: 90,
                            child: RawMaterialButton(
                              elevation: 10,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.add_a_photo,
                                color: kPrimaryColor,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Choose option",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                              onTap: _pickImageCamera,
                                              splashColor: kPrimaryColor,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.camera,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _pickImageGallery,
                                              splashColor: kPrimaryColor,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.photo,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _removeImage,
                                              splashColor: kPrimaryColor,
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: Column(
                          children: [
                            const Text(
                              "Personal Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // Name field
                            fullName,
                            const SizedBox(height: 1),

                            // email field
                            emailField,
                            const SizedBox(height: 1),

                            // phone field
                            phoneNo,
                            const SizedBox(height: 1),

                            // password field
                            // passwordField,
                            // const SizedBox(height: 1),

                            // // confirm password field
                            // confirmPasswordField,

                            const Text(
                              "Gender",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // gender radio btn
                            genderRadioBtn,
                            dateOfBirth,
                            const Text(
                              "Nationality",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),

                            // nationality field
                            nationality,

                            // location field
                            location,

                            // address field
                            address,

                            // idnumber field
                            idNumber,

                            const Text(
                              "Register As",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // skill level radiobtn
                            skillLevelRadioBtn,

                            // yrs of experience
                            yearsOfExperience,

                            const Text(
                              "Specialisation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // specialization,
                            specialization,
                            const Text(
                              "Availability Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            status,
                            Text(
                              'You can list more at personal description',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption,
                            ),

                            const SizedBox(height: 3),
                            const Text(
                              "Referee details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // referee
                            refereeName,
                            // referee phoneno
                            refereePhoneNo,

                            const Text(
                              "Expected Salary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            // salary,
                            salary,
                            // description,
                            const Text(
                              "More about yourself",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            description,
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      signUpBtn,
                      const SizedBox(height: 20),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate() || imagePath == null) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          isLoading = false;
        });
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Fill in all fields!",
        ),
      );
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModelAdmin userModel = UserModelAdmin();
    var fileName = user!.email! + '.jpg';
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('profileimages/$fileName')
        .putFile(imagePath!);
    setState(() {});
    TaskSnapshot snapshot = await uploadTask;
    String profileImageUrl = await snapshot.ref.getDownloadURL();

    String role = 'employee';

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.phone = phoneController.text;
    userModel.imageUrl = profileImageUrl;
    userModel.role = role;
    userModel.gender = gender;
    userModel.location = locationController.text;
    userModel.salary = salaryController.text;
    userModel.nationality = nationalityController.text;
    userModel.descriprion = descriptionController.text;
    userModel.dateofbirth = dateOfBirthController.text;
    userModel.address = addressController.text;
    userModel.idNumber = idNumberController.text;
    userModel.yearsOfExperience = yearsOfExperienceController.text;
    userModel.skillLevel = skillLevel;
    userModel.specialization = specializeIn;
    userModel.refereeName = refereeNameController.text;
    userModel.refereePhoneNumber = refereePhoneNumberController.text;
    userModel.availabilityStatus = availabilityStatus;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => AdminBottomNavBar()),
        (route) => false);
    // ignore: use_build_context_synchronously
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "Employee added successfully!",
      ),
    );
  }

  // pickCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark placemark = placemarks[0];
  //   String? locality = placemark.locality;
  //   String? country = placemark.country;
  //   String formatedAddress = "$locality, $country";
  //   locationController.text = formatedAddress;
  // }
}
