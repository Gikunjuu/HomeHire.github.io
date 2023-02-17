import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'invoice.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of all checkouts"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('bookings').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot booking = snapshot.data!.docs[index];
                String employerName = booking['employerName'] ?? 'Unknown';
                String employerPhone = booking['employerPhone'] ?? 'Unknown';
                String employerEmail = booking['employerEmail'] ?? 'Unknown';
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(employerName),
                      subtitle: Text(employerPhone),
                      trailing: Text(employerEmail),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Invoice(),
                            ),
                          );
                        },
                        child: Text("Generate Invoice"),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
