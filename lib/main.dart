import 'package:chatbot/pages/chat/repository/save_hive_data.dart';
import 'package:chatbot/pages/chat/bloc/bloc.dart';
import 'package:chatbot/pages/chat/chat_page.dart';
import 'package:chatbot/pages/onboard/login.dart';
import 'package:chatbot/utils/conts_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';



void main() async {
//init hive
  await Hive.initFlutter();
  await Hive.openBox(boxName);
  await Hive.openBox(users);

  //init gemini
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MessageBloc(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: (boxUser.isEmpty || !boxUser.get('islogin'))
                ? Login()
                : ChatPage()));
  }
}
