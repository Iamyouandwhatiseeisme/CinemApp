import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cinemapp/data/constants/tmdb_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:cinemapp/data/models/models.dart';
import 'package:http/http.dart' as http;

part 'fetch_movies_state.dart';

class FetchMoviesCubit extends Cubit<FetchMoviesState> {
  FetchMoviesCubit() : super(FetchMoviesInitial());

  Future<List<MovieModel>> fetchMovies(
      {required List<String> moviesList}) async {
    List<MovieModel> movieModels = [];

    emit(FetchMoviesLoading());
    for (final name in moviesList) {
      String url =
          'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&query=$name';
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final results = data['results'] as List;

          final exactMatch = results.firstWhere(
              (movie) => movie['title'].toLowerCase() == (name.toLowerCase()),
              orElse: () => null);

          if (exactMatch != null) {
            try {
              String url =
                  'https://api.themoviedb.org/3/movie/${exactMatch['id'].toString()}?api_key=${Constants.apiKey}';
              final response = await http.get(Uri.parse(url));
              if (response.statusCode == 200) {
                final movie = MovieModel.fromJson(jsonDecode(response.body));
                movieModels.add(movie);
              }
            } catch (e) {
              emit(
                FetchMoviesError(
                  errorMessage: e.toString(),
                ),
              );
            }
          }
        }
      } catch (e) {
        emit(
          FetchMoviesError(
            errorMessage: e.toString(),
          ),
        );
      }
    }
    if (movieModels.isNotEmpty) {
      emit(FetchMoviesLoaded(movieModels: movieModels));
    } else {
      emit(const FetchMoviesError(errorMessage: 'No movies to show'));
    }

    return movieModels;
  }
}
