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
    BlocProvider.of<RemoteDataBaseInitiate>(context)
        .sendChatMessage(message: chatController.text);

    chatController.clear();
    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.secondary
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ),
          ),
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
              BlocProvider.of<RemoteDataBaseInitiate>(context).update();
            }
          },
          child: BlocListener<RemoteDataBaseInitiate, RemoteDataBaseState>(
            listener: (context, state) {},
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
                              movieDataList = text.split('\n');

                              return BlocProvider(
                                create: (context) => FetchMoviesCubit(),
                                child: MessageWidget(
                                  movieDataList: movieDataList,
                                  movieListTMDBIDs: tmdbIds,
                                  text: text,
                                  isFromUser: content.role == 'user',
                                ),
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
                  print('Building');
                  return const Center(
                    child: LinearProgressIndicator(
                      semanticsLabel:
                          'Please wait while gemini is loading your movies',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
