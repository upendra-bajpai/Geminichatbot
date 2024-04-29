import 'package:chatbot/pages/chat/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/conts_utils.dart';
import '../../../widgets/component.dart';
import '../../onboard/models/user_model.dart';
import '../model/chat_model.dart';
import '../repository/chatbot_api_call.dart';

class BuildInputBox extends StatelessWidget {
  late List<ChatModel> textMessages;
  late User user1;
  User botUser = User(firstName: 'ChatBot', userID: '2');
  bool isWriting = false;

  final _controller = TextEditingController();
  BuildInputBox({super.key, required this.textMessages, required this.user1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: MessageField(
            text: "Ask Me, I Can Help You...",
            controller: _controller,
          )),
          IconButton(
              onPressed: () async {
                final blocContext = BlocProvider.of<MessageBloc>(context);
                if (_controller.text.trim().isNotEmpty && !isWriting) {
                  isWriting = true;
                  ChatModel message = ChatModel(
                    createAt: DateTime.now(),
                    text: _controller.text.trim(),
                    user: user1,
                  );
                  _controller.clear();
                  textMessages.add(message);
                  BlocProvider.of<MessageBloc>(context).add(DataSent());

                  BlocProvider.of<MessageBloc>(context).add(Pending());

                  textMessages.add(await getBotResponse(message, botUser));

                  blocContext.add(DataRecieving());
                }
                isWriting = false;
              },
              icon: const Icon(
                Icons.send,
                color: senderColor,
              ))
        ],
      ),
    );
  }
}
