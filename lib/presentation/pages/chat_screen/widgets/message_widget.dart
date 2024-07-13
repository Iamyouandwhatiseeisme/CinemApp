import 'package:cinemapp/bloc/cubit/fetch_movies_cubit.dart';
import 'package:cinemapp/bloc/cubit/remote_data_base_cubit.dart';
import 'package:cinemapp/bloc/cubit/remote_data_base_state.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/data.dart';

class MessageWidget extends StatefulWidget {
  final List<String> movieDataList;
  final String text;
  final bool isFromUser;
  final List<String> movieListTMDBIDs;
  final List<String> moviesList;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
    required this.movieListTMDBIDs,
    required this.movieDataList,
    required this.moviesList,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final Util util = Util();
  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchMoviesCubit()..fetchMovies(moviesList: widget.moviesList),
      child: BlocListener<RemoteDataBaseInitiate, RemoteDataBaseState>(
        listener: (context, state) async {},
        child: Row(
          mainAxisAlignment: widget.isFromUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
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
                          child:
                              BlocBuilder<FetchMoviesCubit, FetchMoviesState>(
                            builder: (context, state) {
                              if (state is FetchMoviesLoaded) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return ReportDialog(
                                                            reportedText:
                                                                widget.text);
                                                      },
                                                      context: context),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 28.0),
                                                    child: Icon(Icons.flag),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          late String poster;
                                          final posterPath = state
                                              .movieModels[index].posterPath;
                                          posterPath != null
                                              ? poster =
                                                  'https://image.tmdb.org/t/p/original/$posterPath'
                                              : poster =
                                                  'assets/images/No_Image_Available.jpg';

                                          return Column(
                                            children: [
                                              Text(state
                                                  .movieModels[index].title!),
                                              SizedBox(
                                                height: 150,
                                                width: 200,
                                                child: Image.network(
                                                  fit: BoxFit.contain,
                                                  poster,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null),
                                                    );
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    print(state
                                                        .movieModels[index]
                                                        .homepage);
                                                    if (state.movieModels[index]
                                                                .homepage !=
                                                            null &&
                                                        state
                                                            .movieModels[index]
                                                            .homepage!
                                                            .isNotEmpty) {
                                                      launchUrl(Uri.parse(state
                                                          .movieModels[index]
                                                          .homepage!));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Coulnt'find homepage for the move")));
                                                    }
                                                  },
                                                  child:
                                                      const Text("More info"))
                                            ],
                                          );
                                        }),
                                        itemCount: state.movieModels.length,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final moviesList =
                                            await util.extractMovieNames(
                                                widget.movieDataList);
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
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        BlocProvider.of<RemoteDataBaseInitiate>(
                                                context)
                                            .sendChatMessage(
                                                message:
                                                    'Repeat the answer with the previous prompt but with 10 other movies');
                                      },
                                      child: const Text(
                                        'See more',
                                        style: TextStyle(
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is FetchMoviesLoading) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  semanticsLabel:
                                      'Posters are loading, please wait...',
                                ));
                              } else if (state is FetchMoviesError) {
                                return Center(child: Text(state.errorMessage));
                              } else if (state is FetchMoviesInitial) {
                                return const Center(
                                  child: Text(
                                      "An unexpected error has occured, please reload the application"),
                                );
                              } else {
                                return const Center(
                                  child: Text('Unknown state'),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
