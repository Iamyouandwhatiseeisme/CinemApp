// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinemapp/bloc/cubits.dart';
import 'package:cinemapp/presentation/presentation.dart';

import '../../../data/data.dart';

class PostersScreen extends StatefulWidget {
  const PostersScreen({super.key});

  @override
  State<PostersScreen> createState() => _PostersScreenState();
}

class _PostersScreenState extends State<PostersScreen> {
  final Util util = Util();
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
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back)),
              ),
              body: BlocListener<FetchMoviesCubit, FetchMoviesState>(
                listener: (context, state) {
                  if (state is FetchMoviesLoaded) {}
                },
                child: BlocBuilder<FetchMoviesCubit, FetchMoviesState>(
                  builder: (context, state) {
                    if (state is FetchMoviesLoaded) {
                      return CarouselSlider.builder(
                        itemCount: state.movieModels.length,
                        options: CarouselOptions(
                            height: double.infinity,
                            autoPlay: false,
                            viewportFraction: 0.90,
                            enlargeCenterPage: true,
                            pageSnapping: true),
                        itemBuilder: (context, itemIndex, countIndex) {
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
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${movieModel.title!} ',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '(${movieModel.releaseDate!.substring(
                                        0,
                                        movieModel.releaseDate!.indexOf('-'),
                                      )})'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(movieModel.adult == true
                                          ? '18+'
                                          : 'PA')
                                    ],
                                  ),
                                  PosterCard(
                                      posterPath: poster,
                                      movieModel: movieModel),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Overview'),
                                  ),
                                  const Divider(),
                                  Text(movieModel.overview!),
                                  const Divider(),
                                  HorizontalList(
                                    movieModel: movieModel,
                                  ),
                                  const Divider(),
                                  Text(
                                      '${util.addCommas(movieModel.revenue!)}\$')
                                ],
                              ),
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
                ),
              )),
        );
      }),
    );
  }
}

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    super.key,
    required this.movieModel,
  });
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Genres: '),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Text(', ');
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: movieModel.genres!.length,
                  itemBuilder: ((context, index) {
                    final movieGenreList = movieModel.genres;
                    return Text(movieGenreList![index].name!);
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
