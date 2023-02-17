import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/chat_module/components/utils/ChatDetailPage.dart';
import 'package:home_hire_app/constants/constants.dart';

class ChatUsersList extends StatefulWidget {
  String text;
  String secondaryText;
  String image;
  String? time;
  bool isMessageRead;
  ChatUsersList({
    required this.text,
    required this.secondaryText,
    required this.image,
    this.time,
    this.isMessageRead = true,
  });
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.text,
                          style: Theme.of(context).textTheme.button,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(widget.secondaryText,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "time",
            style: TextStyle(
                fontSize: 12,
                color: widget.isMessageRead
                    ? kPrimaryColor
                    : Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
