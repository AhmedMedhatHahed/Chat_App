import 'package:flutter/material.dart';
import 'package:task/models/message_model.dart';
import '../consts/constants.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.message
  }):super(key: key);
    final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0),
            )),
        child: Text(
         message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}