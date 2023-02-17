import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  String? uid;
  String? content;
  String? senderUID;
  String? receiverUID;
  Timestamp? createdAt;
  Message(
      {this.content,
      this.createdAt,
      this.senderUID,
      this.receiverUID,
      this.uid});
  Message.fromJson(Map<String, dynamic> json, String id) {
    uid = id;
    content = json['content'];
    senderUID = json['senderUID'];
    receiverUID = json['receiverUID'];
    createdAt = json['createdAt'];
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'createdAt': createdAt,
    };
  }

  bool get isMe => AuthServices().user.uid == senderUID;
}

class AuthServices {
  User get user => FirebaseAuth.instance.currentUser!;
}
