// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:chatbot/pages/chat/repository/save_hive_data.dart';
import 'package:chatbot/widgets/component.dart';
import 'package:chatbot/pages/chat/chat_page.dart';
import 'package:chatbot/utils/conts_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  var output;
  var box = Hive.box(boxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(children: [
          Container(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 100),
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 4),
              child: Image.asset('./assets/gemini.png')),
          const Center(
              child: Text(
            'CHATBOT',
            style: TextStyle(
                color: Color.fromARGB(255, 6, 4, 95), fontSize: 30, fontWeight: FontWeight.w900),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Textfield(
            
              text: ' First Name',
              controller: textEditingController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Textfield(
              text: 'Last Name',
              controller: textEditingController1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: 'Login',
              onpressed: () {
                if (textEditingController.text.isNotEmpty &&
                    textEditingController1.text.isNotEmpty) {
                  savingUser(textEditingController.text.trim(),
                      textEditingController1.text.trim());
                  boxUser.put('islogin', true);
                  final route =
                      MaterialPageRoute(builder: (builder) => ChatPage());
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                  textEditingController.clear();
                  textEditingController1.clear();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
