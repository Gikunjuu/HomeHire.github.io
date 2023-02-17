import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/message.dart';

class DBservices {
  var messagesCollection = FirebaseFirestore.instance.collection("chats");

  Stream<List<Message>> getMessage(String receiverUID,
      [bool myMessage = true]) {
    return messagesCollection
        .where('senderUID',
            isEqualTo: myMessage ? AuthServices().user.uid : receiverUID)
        .where('receiverUID',
            isEqualTo: myMessage ? receiverUID : AuthServices().user.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> sendMessage(Message msg) async {
    try {
      await messagesCollection.doc().set(msg.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
