import 'package:cinemapp/bloc/cubits.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  final ScrollController chatScrollController = ScrollController();

  @override
  void dispose() {
    chatScrollController.dispose();
    super.dispose();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RemoteDataBaseInitiate, RemoteDataBaseState>(
        builder: (context, state) {
          if (state is RemoteDatabaseLoaded) {
            return Column(
              children: [
                Expanded(
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
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
