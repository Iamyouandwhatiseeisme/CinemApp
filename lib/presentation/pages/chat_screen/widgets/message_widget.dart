import 'package:cinemapp/bloc/cubit/remote_data_base_cubit.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageWidget extends StatefulWidget {
  final List<String> movieDataList;
  final String text;
  final bool isFromUser;
  final List<String> movieListTMDBIDs;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
    required this.movieListTMDBIDs,
    required this.movieDataList,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  Future<List<String>> extractMovieNames(List<String> data) async {
    final movieList = <String>[];
    for (final movie in data) {
      final parts = movie.split('-');
      for (final part in parts) {
        if (part.trim().contains('Title:** ')) {
          final movieName = part.trim().split('** ').last;
          movieList.add(movieName);
          break; // Stop searching after finding TMDB ID
        }
        if (part.trim().contains('Title: ')) {
          final movieName = part.trim().split('Title: ').last;
          movieList.add(movieName);
          break;
        }
      }
    }
    return movieList;
  }

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
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.secondary
                      ],
                    ),
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.5),
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/google-gemini-icon.svg',
                                        width: 100,
                                        height: 50,
                                      ),
                                      const Text(
                                        'Gemini',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      GestureDetector(
                                        onTap: () => showDialog(
                                            builder: (BuildContext context) {
                                              return ReportDialog(
                                                  reportedText: widget.text);
                                            },
                                            context: context),
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 28.0),
                                          child: Icon(Icons.flag),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ],
                          ),
                          Text(widget.text.trim()),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final moviesList =
                                  await extractMovieNames(widget.movieDataList);
                              if (context.mounted) {
                                Navigator.pushNamed(
                                  context,
                                  NavigatorClient.postersScreen,
                                  arguments: PostersScreenPagePayload(
                                      moviesList: moviesList),
                                );
                              }
                            },
                            child: const Text(
                              'See posters',
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              BlocProvider.of<RemoteDataBaseInitiate>(context)
                                  .sendChatMessage(
                                      message:
                                          'Repeat the answer with the previous prompt but with 10 other movies');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
