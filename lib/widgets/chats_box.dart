import 'package:chatbot/widgets/waiting_message.dart';
import 'package:chatbot/pages/chat/model/chat_model.dart';
import 'package:chatbot/utils/conts_utils.dart';
import 'package:chatbot/utils/functions_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ChatBox extends StatelessWidget {
  ChatModel chatModel;
  ChatBox({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return chatModel.isWaiting
        ? const WaitingMessage()
        : Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            constraints: const BoxConstraints(maxWidth: 250, minWidth: 40),
            child: Column(children: [
              Align(
                  alignment: chatModel.isSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: chatModel.isSender ? Colors.green : Colors.blue),
                    child: Center(child: Text(chatModel.user.firstName[0])),
                  )),
              const Padding(padding: EdgeInsets.all(3)),
              Align(
                  alignment: chatModel.isSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      constraints: const BoxConstraints(maxWidth: 350),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              !chatModel.isSender ? chatbotColor : senderColor),
                      child: Column(
                        children: [
                          Align(
                            alignment: !chatModel.isSender
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: chatModel.isSender
                                      ? senderColor
                                      : chatbotColor,
                                ),
                                child: Align(
                                    alignment: chatModel.isSender
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      chatModel.text,
                                      style: const TextStyle(
                                          color: white, fontSize: 19),
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                                alignment: chatModel.isSender
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Text(formattedDate(chatModel.createAt),
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 16,
                                    ))),
                          )
                        ],
                      )))
            ]));
  }
}
