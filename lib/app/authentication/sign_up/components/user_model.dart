import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;

  String? phone;
  String? uid;
  String? role;
  // String? gender;
  DateTime location = DateTime.now();
  DateTime nationality = DateTime.now(); // String? salary;
  // String? salary;
  // String? ;
  // String? descriprion;
  // String? dateofbirth;
  // String? address;
  String? idNumber;
  // String? yearsOfExperience;
  String? skillLevel;
  // String? specialization;
  // String? refereeName;
  // String? refereePhoneNumber;
  // String? availabilityStatus;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.role,
    // this.gender,
    required this.location,
    required this.nationality,
    // this.salary,
    // this.descriprion,
    // this.dateofbirth,
    // this.address,
    this.idNumber,
    // this.yearsOfExperience,
    this.skillLevel,
    // this.specialization,
    // this.refereeName,
    // this.refereePhoneNumber,
    // this.availabilityStatus,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      uid: map['uid'],
      role: map['role'],

      // gender: map['gender'],
      location: map['Date of Occupation'],
      // salary: map['salary'],
      nationality: map['Date of Depature'],
      // descriprion: map['description'],
      // dateofbirth: map['dateofbirth'],
      // address: map['address'],
      idNumber: map['Registration Number'],
      // yearsOfExperience: map['yearsOfExperience'],
      skillLevel: map['Hostel'],
      // specialization: map['specialization'],
      // refereeName: map['refereeName'],
      // refereePhoneNumber: map['refereePhoneNumber'],
      // availabilityStatus: map['availabilityStatus'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uid': uid,
      'role': role,

      // 'gender': gender,
      'Date of Occupation': location,
      // 'salary': salary,
      'Date of Depature': nationality,
      // 'description': descriprion,
      // 'dateofbirth': dateofbirth,
      // 'address': address,
      'Registration Number': idNumber,
      // 'yearsOfExperience': yearsOfExperience,
      'Hostel': skillLevel,
      // 'specialization': specialization,
      // 'refereePhoneNumber': refereePhoneNumber,
      // 'refereeName': refereeName,
      // 'availabilityStatus': availabilityStatus,
    };
  }
}
