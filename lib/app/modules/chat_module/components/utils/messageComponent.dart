import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/message.dart';
import 'package:home_hire_app/constants/constants.dart';

class MessageComponent extends StatelessWidget {
  MessageComponent({Key? key, this.msg}) : super(key: key);
  final Message? msg;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    var date = msg!.createdAt!.toDate().toLocal();
    return Row(
      mainAxisAlignment:
          msg!.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: msg!.isMe
                    ? kPrimaryColor.withOpacity(0.3)
                    : kPrimaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      msg!.isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      msg!.isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              constraints: BoxConstraints(
                minWidth: 40, minHeight: 40, maxWidth: size.width / 1.7,
                // maxWidth: width / 1.1,
              ),
              child: Text(
                msg!.content!,
                textAlign: TextAlign.start,
                style: msg!.isMe
                    ? TextStyle(color: Colors.black)
                    : TextStyle(color: Colors.white),
              ),
            ),
            const Divider(),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(right: 5, bottom: 1),
                child: Text(
                  "${date.hour}h${date.minute}",
                  style: msg!.isMe
                      ? TextStyle(fontSize: 10, color: Colors.white)
                      : TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
