import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatbot/main.dart';
import 'package:chatbot/pages/onboard/models/user_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:chatbot/pages/chat/model/chat_model.dart';
import '../../../utils/conts_utils.dart';

/**
 * Top p (Nucleus Sampling): This parameter controls the randomness in text generation by focusing on the most probable next words. A lower value of top p means the model will choose from a smaller set of words, leading to more predictable text.
Top k: This parameter limits the number of highest probability vocabulary tokens considered for generating a word in the sequence. Setting top k to a small number can make the model’s outputs more deterministic.
Temperature: This parameter helps to control the randomness of predictions by scaling the logits before applying softmax. A higher temperature results in more random completions, while a lower temperature makes the model more confident in its top choices.
Stop Sequence: This is a specific sequence of tokens at which the model will stop generating further content. It acts as a delimiter to signal the end of a text generation task.
Max Output Length: This parameter sets the maximum length of the sequence to be generated by the model. It ensures that the output doesn’t exceed a certain number of tokens.
Number of Response Candidates: This parameter specifies how many different responses the model should generate for a given input. Multiple responses can be useful for sampling different ideas or for ensemble methods.
 */
Future<ChatModel> getTrunChatResponse(
    List<ChatModel> messages, ChatModel currentMessage, User gemini) async {
  if (messages.length > 0) {
    late ChatModel chatModel;
    // setup bot
    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: APIKEY,
      generationConfig: GenerationConfig(
          maxOutputTokens: 1024,
          candidateCount: 1,
          temperature: 0.7,
          topK: 40,
          topP: 0.9),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium)
      ],
    );
    // Initialize the chat
    var messageHistroy = List<Content>.empty(growable: true);
    for (int i = 0; i < messages.length - 1; i++) {
      var element = messages[i];
      if (element.isSender)
        messageHistroy.add(Content.text(element.text));
      else
        messageHistroy.add(Content.model([TextPart(element.text)]));
    }
    //print("message ${messageHistroy.first.toJson()}");
    final chat = model.startChat(history: messageHistroy);
    var content = Content.text(currentMessage.text);
    var response = await chat.sendMessage(content);
    print(response.text);

    chatModel = ChatModel(
        user: gemini,
        createAt: DateTime.now(),
        text: response.text ?? "we can't provide you response for this now.",
        isSender: false);

    return chatModel;
  } else {
    return getBotResponse(currentMessage, gemini);
  }
}

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
    (value) {
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
