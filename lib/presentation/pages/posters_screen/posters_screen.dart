import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemapp/bloc/cubits.dart';
import 'package:cinemapp/data/models/movie.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    return CarouselSlider.builder(
                      itemCount: state.movieModels.length,
                      options: CarouselOptions(
                          height: 300,
                          autoPlay: false,
                          viewportFraction: 0.55,
                          enlargeCenterPage: true,
                          pageSnapping: true),
                      itemBuilder: (context, itemIndex, pageViewId) {
                        late String poster;
                        final movieModel = state.movieModels[itemIndex];
                        final posterPath =
                            state.movieModels[itemIndex].posterPath;
                        posterPath != null
                            ? poster =
                                'https://image.tmdb.org/t/p/original/$posterPath'
                            : poster = 'assets/images/No_Image_Available.jpg';

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PosterCard(
                              posterPath: poster, movieModel: movieModel),
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
        child: Builder(builder: (context) {
          if (posterPath != null) {
            return SizedBox(
              width: 400,
              child: Image.network(
                fit: BoxFit.fill,
                posterPath!,
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
            return SizedBox(width: 400, child: Image.asset(posterPath!));
          }
        }),
      ),
    );
  }
}
