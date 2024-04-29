import 'dart:io';
import 'package:chatbot/pages/chat/repository/save_hive_data.dart';
import 'package:chatbot/pages/chat/repository/chatbot_api_call.dart';
import 'package:chatbot/pages/chat/bloc/bloc.dart';
import 'package:chatbot/widgets/chats_box.dart';
import 'package:chatbot/widgets/component.dart';
import 'package:chatbot/pages/chat/model/chat_model.dart';
import 'package:chatbot/pages/onboard/models/user_model.dart';
import 'package:chatbot/pages/onboard/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/chat_model.dart';
import '../repository/save_hive_data.dart';
import '../../../utils/conts_utils.dart';

class BuildMessageList extends StatelessWidget {
  List<ChatModel> textMessages;
  ScrollController scroll;
  User user;
  User botUser = User(firstName: 'ChatBot', userID: '2');
  BuildMessageList(
      {super.key,
      required this.textMessages,
      required this.scroll,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
          if (state is InitialState) {
    return initalState();
          } else if (state is SendingState) {
    return sendingState();
          } else if (state is RecievingState) {
    return recievedState();
          } else {
    return removeWaitandSave();
          }
        });
  }

  Widget initalState() {
    print("InitialState");
    return ListView.builder(
        controller: scroll,
        itemCount: textMessages.length,
        itemBuilder: (context, index) {
          return ChatBox(
            chatModel: textMessages[index],
          );
        });
  }

  Widget sendingState() {
    print("SendingState");
    saveMsgData(textMessages);

    return ListView.builder(
        controller: scroll,
        itemCount: textMessages.length,
        itemBuilder: (context, index) {
          return ChatBox(
            chatModel: textMessages[index],
          );
        });
  }

  Widget recievedState() {
    print('RecievingState');
    ChatModel chatModel = ChatModel(
        text: 'text',
        user: botUser,
        createAt: DateTime.now(),
        isWaiting: true,
        isSender: false);
    textMessages.add(chatModel);
    return ListView.builder(
        controller: scroll,
        itemCount: textMessages.length,
        itemBuilder: (context, index) {
          return ChatBox(
            chatModel: textMessages[index],
          );
        });
  }

  Widget removeWaitandSave() {
    print("what");

    //to remove waiting response widget
    if (textMessages.length > 2) {
      print(textMessages[textMessages.length - 2].text);
      textMessages.removeAt(textMessages.length - 2);
      saveMsgData(textMessages);
    }

    return ListView.builder(
        controller: scroll,
        itemCount: textMessages.length,
        itemBuilder: (context, index) {
          return ChatBox(
            chatModel: textMessages[index],
          );
        });
  }
}
