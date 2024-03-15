part of 'remote_data_base_messanger_cubit.dart';

sealed class RemoteDataBaseMessangerState extends Equatable {
  const RemoteDataBaseMessangerState();

  @override
  List<Object> get props => [];
}

final class RemoteDataBaseMessangerInitial
    extends RemoteDataBaseMessangerState {}

final class RemoteDataBaseMessangerLoading
    extends RemoteDataBaseMessangerState {}

final class RemoteDataBaseMessangerLoaded extends RemoteDataBaseMessangerState {
  final String text;

  const RemoteDataBaseMessangerLoaded({required this.text});
  @override
  List<Object> get props => [text];
}

final class RemoteDataBaseMessangerError extends RemoteDataBaseMessangerState {
  final Exception errorMessage;

  const RemoteDataBaseMessangerError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
