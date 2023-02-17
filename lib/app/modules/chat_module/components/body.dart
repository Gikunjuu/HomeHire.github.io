import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/ChatDetailPage.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/ChatUsersList.dart';
import 'package:home_hire_app/app/modules/utils/userCard/userCard.dart';
import 'package:home_hire_app/constants/constants.dart';

class chat_body extends StatefulWidget {
  chat_body({Key? key}) : super(key: key);

  @override
  State<chat_body> createState() => _chat_bodyState();
}

class _chat_bodyState extends State<chat_body> {
  TextEditingController? _searchController = TextEditingController();
  String? name = '';
  late Future _data;
  var emailIdentifier = FirebaseAuth.instance.currentUser!.email;

  Future getUsers() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        // .collection('bookings')
        // .where("employerEmail", isEqualTo: "$emailIdentifier")
        .get();
    return qn.docs;
  }

  navigateToChatDetails(DocumentSnapshot user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatDetailPage(
                  user: user,
                )));
  }

  @override
  void initState() {
    super.initState();
    _data = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          "My Chats",
          style: Theme.of(context).textTheme.button!.copyWith(fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: SpinKitChasingDots(color: kPrimaryColor),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            if (name!.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  navigateToChatDetails(snapshot.data[index]);
                                },
                                child: ChatUsersList(
                                  text: snapshot.data[index]['name'],
                                  // ["serviceProviderName"],
                                  secondaryText: snapshot.data[index]['name'],
                                  // ["serviceProviderLocation"],
                                  image: snapshot.data[index]['imageUrl'],
                                  // ["serviceProviderImageUrl"],
                                ),
                              );
                            }
                            if (snapshot.data[index]['name']
                                // ['serviceProviderName']
                                .toString()
                                .startsWith(name!)) {
                              return GestureDetector(
                                onTap: () {
                                  navigateToChatDetails(snapshot.data[index]);
                                },
                                child: ChatUsersList(
                                  text: snapshot.data[index]['name'],
                                  // ["serviceProviderName"],
                                  secondaryText: snapshot.data[index]['name'],
                                  // ["serviceProviderLocation"],
                                  image: snapshot.data[index]['imageUrl'],
                                  // ["serviceProviderImageUrl"],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}













































































































































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:home_hire_app/app/modules/chat_module/components/chatRoom.dart';
// import 'package:home_hire_app/app/modules/utils/textFieldContainer/textFieldContainer.dart';
// import 'package:home_hire_app/constants/constants.dart';

// class chat_body extends StatefulWidget {
//   chat_body({Key? key}) : super(key: key);

//   @override
//   State<chat_body> createState() => _chat_bodyState();
// }

// class _chat_bodyState extends State<chat_body> with WidgetsBindingObserver {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     setStatus("Online");
//   }

//   void setStatus(String status) async {
//     await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
//       "status": status,
//     });
//   }

//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setStatus("Online");
//     } else {
//       setStatus("Offline");
//     }
//   }

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Map<String, dynamic>? userMap;
//   final TextEditingController _search = TextEditingController();
//   bool isLoading = false;
//   void onSearch() async {
//     // FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     setState(() {
//       isLoading = true;
//     });

//     await _firestore
//         .collection('users')
//         .where('name', isGreaterThanOrEqualTo: _search.text)
//         .get()
//         .then((value) {
//       setState(() {
//         userMap = value.docs[0].data();
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return const SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Text("Chats Screen"),
//         ),
//       ),
//       // child: Scaffold(
//       //   // appBar: AppBar(
//       //   //   backgroundColor: Colors.white,
//       //   //   automaticallyImplyLeading: false,
//       //   //   title: Text(
//       //   //     "Chat",
//       //   //     style: Theme.of(context).textTheme.bodyText1,
//       //   //   ),
//       //   // ),
//       //   body: isLoading
//       //       ? Center(
//       //           child: Container(
//       //             // height: size.height / 20,
//       //             // width: size.height / 20,
//       //             child: const SpinKitChasingDots(
//       //               color: kPrimaryColor,
//       //             ),
//       //           ),
//       //         )
//       //       : Column(
//       //           children: <Widget>[
//       //             SizedBox(height: size.height / 35),
//       //             const Text(
//       //               "Chats",
//       //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: size.height / 35),
//       //             Container(
//       //               height: size.height / 14,
//       //               width: size.width,
//       //               alignment: Alignment.center,
//       //               child: Container(
//       //                 height: size.height / 14,
//       //                 width: size.width / 1.2,
//       //                 child: TextField(
//       //                   controller: _search,
//       //                   decoration: InputDecoration(
//       //                     hintText: "Search for a user",
//       //                     suffixIcon: IconButton(
//       //                       onPressed: onSearch,
//       //                       icon: const Icon(Icons.search_sharp),
//       //                     ),
//       //                     border: OutlineInputBorder(
//       //                       borderRadius: BorderRadius.circular(10),
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //             SingleChildScrollView(
//       //               child: userMap != null
//       //                   ? ListTile(
//       //                       onTap: () {
//       //                         String roomId = chatRoomId(
//       //                             _auth.currentUser!.displayName!,
//       //                             userMap!['name']);
//       //                         Navigator.of(context).push(MaterialPageRoute(
//       //                             builder: (_) => ChatRoom(
//       //                                   chatRoomId: roomId,
//       //                                   userMap: userMap!,
//       //                                 )));
//       //                       },
//       //                       leading: CircleAvatar(
//       //                         radius: 40,
//       //                         backgroundImage:
//       //                             NetworkImage(userMap!['imageUrl']),
//       //                       ),
//       //                       title: Text(
//       //                         userMap!['name'],
//       //                         style: Theme.of(context).textTheme.bodyText2,
//       //                       ),
//       //                       subtitle: Text(
//       //                         userMap!['email'],
//       //                         style: Theme.of(context).textTheme.caption,
//       //                       ),
//       //                       trailing: const Icon(Icons.chat),
//       //                     )
//       //                   : Container(),
//       //             )
//       //           ],
//       //         ),
//       // ),
//     );
//   }
// }
