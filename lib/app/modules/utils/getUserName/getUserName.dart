import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/utils/userCard/userCard.dart';

class getUserName extends StatelessWidget {
  late final String documentId;

  getUserName({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            child: Column(
              children: [
                userCard(
                  name: "Name: " '${data['name']}',
                  location: "Location: " '${data['location']}',
                  nationality: "Nationality: " '${data['nationality']}',
                  salary: "Ksh. " '${data['salary']}' " /day",
                  imageUrl: '${data['imageUrl']}',
                ),
              ],
            ),
          );
        }
        return const Text("Loading...");
      }),
    );
  }
}
