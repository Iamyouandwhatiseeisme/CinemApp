import 'package:cinemapp/bloc/cubits.dart';
import 'package:cinemapp/data/models/movie.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PostersScreen extends StatefulWidget {
  const PostersScreen({super.key});

  @override
  State<PostersScreen> createState() => _PostersScreenState();
}

class _PostersScreenState extends State<PostersScreen> {
  final stockPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/c/c2/No_image_poster.png';
  @override
  Widget build(BuildContext context) {
    final PostersScreenPagePayload placePagePayLoad =
        ModalRoute.of(context)!.settings.arguments as PostersScreenPagePayload;

    return BlocProvider(
      create: (context) => FetchMoviesCubit()
        ..fetchMovies(moviesList: placePagePayLoad.moviesList),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
            ),
            body: BlocListener<FetchMoviesCubit, FetchMoviesState>(
              listener: (context, state) {
                if (state is FetchMoviesError) {
                  print(state.errorMessage);
                }
              },
              child: BlocBuilder<FetchMoviesCubit, FetchMoviesState>(
                builder: (context, state) {
                  print(state);

                  if (state is FetchMoviesLoaded) {
                    return ListView.builder(
                      itemCount: state.movieModels.length,
                      itemBuilder: (context, id) {
                        final movieModel = state.movieModels[id];
                        final posterPath = state.movieModels[id].posterPath;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PosterCard(
                              posterPath: posterPath, movieModel: movieModel),
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
              ),
            ));
      }),
    );
  }
}

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.posterPath,
    required this.movieModel,
  });

  final String? posterPath;
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
            color: Colors.blueGrey,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movieModel.title!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Builder(builder: (context) {
              if (posterPath != null) {
                return SizedBox(
                  width: 400,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original/$posterPath',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox(
                    width: 400,
                    child: Image.asset('assets/images/No_Image_Available.jpg'));
              }
            }),
            CircularPercentIndicator(
                radius: 25,
                lineWidth: 5.0,
                animation: true,
                percent: movieModel.voteAverage! * 0.1,
                center: Text(
                  "${movieModel.voteAverage!.ceilToDouble() * 10}%",
                  style: const TextStyle(fontSize: 10),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green)
          ],
        ),
      ),
    );
  }
}
