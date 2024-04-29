import 'dart:developer';
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

import '../../utils/conts_utils.dart';
import 'components/input_box.dart';
import 'components/message_list.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  late User userData;

  User botUser = User(firstName: 'ChatBot', userID: '2');
  bool isWriting = false;
  final _scroll = ScrollController();

  List<ChatModel> textMessages = [];
  ChatPage({super.key});


  @override
  Widget build(BuildContext context) {  
    
    userData = createUser();
      textMessages = getMessageHive(userData, botUser);
    return Scaffold(
        appBar: appBar(context),
        backgroundColor: Color.fromARGB(255, 223, 211, 211),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Expanded(child: BuildMessageList(textMessages: textMessages,scroll:_scroll,user:userData),flex: 1,),
              BuildInputBox(textMessages: textMessages,user1: userData,),
            ],
          ),
        ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              var route = MaterialPageRoute(builder: (builder) => Login());
              boxUser.put('islogin', false);
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
            icon: const Icon(Icons.logout)),
      ],
      title: const Text("ChatBot"),
      foregroundColor: Colors.white,
      leading: Image.asset('./assets/gemini.png'),
      backgroundColor:  chatbotColor,
    );
  }
}