import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/db_service.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/message.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/messageComponent.dart';
import 'package:home_hire_app/constants/constants.dart';

class ChatDetailPage extends StatelessWidget {
  final DocumentSnapshot user;
  ChatDetailPage({Key? key, required this.user}) : super(key: key);

  var chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.9,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  backgroundImage: NetworkImage(user['imageUrl']
                      // user["serviceProviderImageUrl"],
                      ),
                  maxRadius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        user['name'],
                        // user["serviceProviderName"],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Online",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: DBservices().getMessage(user.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StreamBuilder<List<Message>>(
                      stream: DBservices().getMessage(user.id, false),
                      builder: (context, snapshott) {
                        if (snapshott.hasData) {
                          var messages = [
                            ...snapshot.data!,
                            ...snapshott.data!
                          ];
                          messages.sort(
                              (i, j) => i.createdAt!.compareTo(j.createdAt!));
                          messages = messages.reversed.toList();
                          return messages.length == 0
                              ? Center(
                                  child:
                                      Text("Your Messages wiil appear here..."),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    final msg = messages[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: MessageComponent(
                                        msg: msg,
                                      ),
                                    );
                                  });
                        } else
                          return Center(
                            child: SpinKitChasingDots(color: kPrimaryColor),
                          );
                      },
                    );
                  } else
                    return Center(
                      child: SpinKitChasingDots(color: kPrimaryColor),
                    );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 0.9),
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(29)),
                    child: TextField(
                      controller: chatController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var msg = Message(
                      content: chatController.text,
                      createdAt: Timestamp.now(),
                      receiverUID: user.id,
                      senderUID: AuthServices().user.uid,
                    );
                    chatController.clear();
                    await DBservices().sendMessage(msg);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
