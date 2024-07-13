import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:cinemapp/data/constants/tmdb_constants.dart';
import 'package:cinemapp/data/models/models.dart';

part 'fetch_movies_state.dart';

class FetchMoviesCubit extends Cubit<FetchMoviesState> {
  FetchMoviesCubit() : super(FetchMoviesInitial());

  Future<void> fetchMovies({required List<String> moviesList}) async {
    List<MovieModel> movieModels = [];
    List<String> errors = [];

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
              } else {
                errors.add('Failed to fetch movie details for $name');
              }
            } catch (e) {
              errors.add(
                  'Error fetching movie details for $name: ${e.toString()}');
            }
          } else {
            errors.add('No exact match found for $name');
          }
        } else {
          errors.add('Failed to search movie $name');
        }
      } catch (e) {
        errors.add('Error searching movie $name: ${e.toString()}');
      }
    }

    if (isClosed) return;

    if (movieModels.isNotEmpty) {
      emit(FetchMoviesLoaded(movieModels: movieModels));
    } else {
      emit(FetchMoviesError(errorMessage: errors.join('\n')));
    }
  }
}
