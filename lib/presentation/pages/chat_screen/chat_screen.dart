import 'package:animated_text_kit/animated_text_kit.dart';
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
  final ScrollController chatScrollController = ScrollController();
  final TextEditingController chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
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

  void sendMessage() {
    BlocProvider.of<RemoteDataBaseMessangerCubit>(context)
        .sendChatMessage(chatController.text);
    chatController.clear();
    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocListener<RemoteDataBaseMessangerCubit,
          RemoteDataBaseMessangerState>(
        listener: (context, state) {
          if (state is RemoteDataBaseMessangerLoaded) {
            BlocProvider.of<RemoteDataBaseInitiate>(context).initiate();
          }
        },
        child: BlocBuilder<RemoteDataBaseInitiate, RemoteDataBaseState>(
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

                          // return Expanded(
                          //   child: content.role == 'user'
                          // ? MessageWidget(
                          //           text: text,
                          //           isFromUser: content.role == 'user',
                          //         )
                          //       : Flexible(
                          //           child: Container(
                          //             constraints:
                          //                 const BoxConstraints(maxWidth: 600),
                          //             decoration: BoxDecoration(
                          //               color: Theme.of(context)
                          //                   .colorScheme
                          //                   .secondary,
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(10.0),
                          //               child: AnimatedTextKit(
                          //                   totalRepeatCount: 1,
                          //                   displayFullTextOnTap: true,
                          //                   repeatForever: false,
                          //                   animatedTexts: [
                          //                     TyperAnimatedText(text.trim())
                          //                   ]),
                          //             ),
                          //           ),
                          //         ),
                          // );
                          // return Expanded(
                          return MessageWidget(
                            text: text,
                            isFromUser: content.role == 'user',
                          );
                          // );
                        }),
                  ),
                  ChatTextField(
                    chatController: chatController,
                    onSubmitted: () => sendMessage(),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.chatController,
    required this.onSubmitted,
  });
  final Function onSubmitted;
  final TextEditingController chatController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (_) => onSubmitted(),
            controller: chatController,
            decoration: InputDecoration(
              hintText: 'Enter any further information',
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<RemoteDataBaseMessangerCubit, RemoteDataBaseMessangerState>(
          builder: (context, state) {
            if (state is RemoteDataBaseMessangerLoaded) {
              return IconButton(
                onPressed: () async {
                  onSubmitted();
                },
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
