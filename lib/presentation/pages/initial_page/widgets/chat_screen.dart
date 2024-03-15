import 'package:cinemapp/bloc/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../presentation.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatScrollController,
  });

  final ScrollController chatScrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteDataBaseInitiate, RemoteDataBaseState>(
      builder: (context, state) {
        if (state is RemoteDatabaseLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: state.chat.history.length,
                controller: chatScrollController,
                itemBuilder: (context, id) {
                  final content = state.chat.history.toList()[id];
                  final text = content.parts
                      .whereType<TextPart>()
                      .map<String>((e) => e.text)
                      .join('');

                  return MessageWidget(
                    text: text,
                    isFromUser: content.role == 'user',
                  );
                }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
