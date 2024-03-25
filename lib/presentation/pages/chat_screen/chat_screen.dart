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
  List<String> tmdbIds = [];
  List<String> movieDataList = [];

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

  List<String> extractTmdbIds(List<String> data) {
    final tmdbIds = <String>[];
    for (final movie in data) {
      final parts = movie.split('-');
      for (final part in parts) {
        if (part.trim().contains('TMDB ID')) {
          final id = part.trim().split(':').last;
          print(id);
          tmdbIds.add(id);
          break; // Stop searching after finding TMDB ID
        }
      }
    }
    return tmdbIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              BlocProvider.of<RemoteDataBaseInitiate>(context).resetChat();
              Navigator.pushReplacementNamed(
                  context, NavigatorClient.initialPage);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocListener<RemoteDataBaseMessangerCubit,
          RemoteDataBaseMessangerState>(
        listener: (context, state) {
          if (state is RemoteDataBaseMessangerLoaded) {
            print('updating');
            BlocProvider.of<RemoteDataBaseInitiate>(context).update();
          }
        },
        child: BlocListener<RemoteDataBaseInitiate, RemoteDataBaseState>(
          listener: (context, state) {
            if (state is RemoteDatabaseLoaded) {}
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
                            state.chat.history.length;
                            final content = state.chat.history.toList()[id];
                            final movieData = content.parts
                                .whereType<TextPart>()
                                .map<String>((e) => e.text)
                                .join('');
                            movieDataList = movieData.split('\n');
                            tmdbIds = extractTmdbIds(movieDataList);

                            print(tmdbIds);
                            return MessageWidget(
                              text: movieData,
                              isFromUser: content.role == 'user',
                            );
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
        BlocBuilder<RemoteDataBaseInitiate, RemoteDataBaseState>(
          builder: (context, state) {
            if (state is RemoteDatabaseLoaded) {
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
