import 'package:flutter/material.dart';
import 'package:home_hire_app/app/modules/chat_module/components/body.dart';

class chat extends StatefulWidget {
  chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chat_body(),
    );
  }
}
