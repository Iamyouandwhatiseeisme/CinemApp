part of 'fetch_movies_cubit.dart';

sealed class FetchMoviesState extends Equatable {
  const FetchMoviesState();

  @override
  List<Object> get props => [];
}

final class FetchMoviesInitial extends FetchMoviesState {}

final class FetchMoviesLoading extends FetchMoviesState {}

final class FetchMoviesLoaded extends FetchMoviesState {
  final List<MovieModel> movieModels;

  const FetchMoviesLoaded({required this.movieModels});
}

final class FetchMoviesError extends FetchMoviesState {
  final String errorMessage;

  const FetchMoviesError({required this.errorMessage});
}
