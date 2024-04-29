import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatbot/main.dart';
import 'package:chatbot/pages/onboard/models/user_model.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:http/http.dart' as http;
import 'package:chatbot/pages/chat/model/chat_model.dart';

Future<ChatModel> getBotResponse(ChatModel message, User Gemini) async {
  late ChatModel chatModel;
  const headers = {'Content-Type': 'application/json'};
  const url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$APIKEY";

  var body = {
    "contents": [
      {
        "parts": [
          {"text": message.text}
        ]
      }
    ]
  };
  await http
      .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
      .then(
    (value){
      var result = jsonDecode(value.body);
      var output = result["candidates"][0]['content']['parts'][0]['text'];
      chatModel = ChatModel(
          user: Gemini,
          createAt: DateTime.now(),
          text: output,
          isSender: false);
      log(chatModel.text);
    },
  ).catchError((onError) {
    chatModel = ChatModel(
        user: Gemini,
        createAt: DateTime.now(),
        text: 'unable to fetch data',
        isSender: false);
  });
  return chatModel;
}

