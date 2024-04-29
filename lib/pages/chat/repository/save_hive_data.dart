import 'dart:io';

import 'package:chatbot/pages/chat/model/chat_model.dart';
import 'package:chatbot/pages/onboard/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../utils/conts_utils.dart';

final _box = Hive.box(boxName);
final boxUser = Hive.box(users);
User createUser() {
  if (boxUser.isNotEmpty) {
    final User1 = User(
        firstName: boxUser.get('fname'),
        lastName: boxUser.get('lname'),
        userID: boxUser.get('userID'));
    return User1;
  }
  return User(firstName: 'test', lastName: 'subject', userID: userID);
}

void savingUser(String fname, String lname) {
  boxUser.put('fname', fname);
  boxUser.put('lname', lname);
  boxUser.put('userID', DateTime.now().toString());
}

void saveMsgData(List<ChatModel> messages) {
  var mainList = [];
  for (var i in messages) {
    var emptyList = [
      i.createAt,
      i.file?.path,
      i.isSender,
      i.isWaiting,
      i.text,
    ];
    mainList.add(emptyList);
  }
  _box.put(userID, mainList);
}

List<ChatModel> getMessageHive(User user1, User Gemini) {
  final listofMessage = _box.get(userID);
  List<ChatModel> listOfMessage = [];
  if (listofMessage != null) {
    for (var i in listofMessage) {
      if (i[1] != null) {
        ChatModel chatModel = ChatModel(
            createAt: i[0],
            file: File(i[1]),
            isSender: i[2],
            isWaiting: i[3],
            text: i[4],
            user: i[2] ? user1 : Gemini);
        listOfMessage.add(chatModel);
      } else {
        ChatModel chatModel = ChatModel(
            createAt: i[0],
            isSender: i[2],
            isWaiting: i[3],
            text: i[4],
            user: i[2] ? user1 : Gemini);
        listOfMessage.add(chatModel);
      }
    }
  }
  return listOfMessage;
}
