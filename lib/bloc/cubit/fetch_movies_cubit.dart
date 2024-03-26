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
      {required List<String> movieListTMDBIDs}) async {
    List<MovieModel> movieModels = [];
    print(movieListTMDBIDs.length);

    emit(FetchMoviesLoading());
    for (final id in movieListTMDBIDs) {
      String url =
          'https://api.themoviedb.org/3/movie/$id?api_key=${Constants.apiKey}';
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final movie = MovieModel.fromJson(jsonDecode(response.body));
          movieModels.add(movie);
        } else {
          return movieModels;
        }
      } catch (e) {
        emit(FetchMoviesError(errorMessage: e.toString()));
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
