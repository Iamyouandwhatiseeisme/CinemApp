import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:cinemapp/presentation/widgets/page_payloads/posters_screen_page_payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../bloc/cubits.dart';

class MessageWidget extends StatefulWidget {
  final String text;
  final bool isFromUser;
  final List<String> movieListTMDBIDs;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
    required this.movieListTMDBIDs,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: widget.isFromUser
              ? Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  decoration: BoxDecoration(
                    color: widget.isFromUser
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: MarkdownBody(
                    selectable: true,
                    data: widget.text,
                  ),
                )
              : Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                          repeatForever: false,
                          animatedTexts: [
                            TyperAnimatedText(widget.text.trim()),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // BlocProvider.of<FetchMoviesCubit>(context)
                            //     .fetchMovies(
                            //         movieListTMDBIDs: widget.movieListTMDBIDs);
                            Navigator.pushNamed(
                                context, NavigatorClient.postersScreen,
                                arguments: PostersScreenPagePayload(
                                    movieListTMDBIDs: widget.movieListTMDBIDs));
                          },
                          child: const Text(
                            'See posters',
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
