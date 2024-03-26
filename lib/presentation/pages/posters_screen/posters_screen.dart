import 'package:cinemapp/bloc/cubits.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostersScreen extends StatefulWidget {
  const PostersScreen({super.key});

  @override
  State<PostersScreen> createState() => _PostersScreenState();
}

class _PostersScreenState extends State<PostersScreen> {
  @override
  Widget build(BuildContext context) {
    final PostersScreenPagePayload placePagePayLoad =
        ModalRoute.of(context)!.settings.arguments as PostersScreenPagePayload;

    return BlocProvider(
      create: (context) => FetchMoviesCubit()
        ..fetchMovies(movieListTMDBIDs: placePagePayLoad.movieListTMDBIDs),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
            ),
            body: BlocBuilder<FetchMoviesCubit, FetchMoviesState>(
              builder: (context, state) {
                if (state is FetchMoviesLoaded) {
                  return GridView.builder(
                    itemCount: state.movieModels.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 0.5),
                    itemBuilder: (context, id) {
                      final movieModel = state.movieModels[id];
                      final posterPath = state.movieModels[id].posterPath;
                      return Container(
                        width: MediaQuery.of(context).size.width / 2 - 0.5,
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/original/$posterPath',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null),
                                );
                              }),
                            ),
                            Text(movieModel.title!),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    semanticsLabel: 'Posters are loading, please wait...',
                  ));
                }
              },
            ));
      }),
    );
  }
}
