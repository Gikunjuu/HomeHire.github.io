import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? phone;
  String? uid;
  String? imageUrl;
  String? role;
  // String? gender;
  // String? location;
  // String? salary;
  // String? nationality;
  // String? descriprion;
  // String? dateofbirth;
  // String? address;
  // String? idNumber;
  // String? yearsOfExperience;
  // String? skillLevel;
  // String? specialization;
  // String? refereeName;
  // String? refereePhoneNumber;
  // String? availabilityStatus;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.imageUrl,
    this.role,
    // this.gender,
    // this.location,
    // this.nationality,
    // this.salary,
    // this.descriprion,
    // this.dateofbirth,
    // this.address,
    // this.idNumber,
    // this.yearsOfExperience,
    // this.skillLevel,
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
      imageUrl: map['imageUrl'],
      uid: map['uid'],
      role: map['role'],
      // gender: map['gender'],
      // location: map['location'],
      // salary: map['salary'],
      // nationality: map['nationality'],
      // descriprion: map['description'],
      // dateofbirth: map['dateofbirth'],
      // address: map['address'],
      // idNumber: map['idNumber'],
      // yearsOfExperience: map['yearsOfExperience'],
      // skillLevel: map['skillLevel'],
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
      'imageUrl': imageUrl,
      'uid': uid,
      'role': role,
      // 'gender': gender,
      // 'location': location,
      // 'salary': salary,
      // 'nationality': nationality,
      // 'description': descriprion,
      // 'dateofbirth': dateofbirth,
      // 'address': address,
      // 'idNumber': idNumber,
      // 'yearsOfExperience': yearsOfExperience,
      // 'skillLevel': skillLevel,
      // 'specialization': specialization,
      // 'refereePhoneNumber': refereePhoneNumber,
      // 'refereeName': refereeName,
      // 'availabilityStatus': availabilityStatus,
    };
  }
}
