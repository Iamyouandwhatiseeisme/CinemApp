import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteDataBaseState extends Equatable {
  const RemoteDataBaseState();

  @override
  List<Object?> get props => [];
}

class RemoteDataBaseInitial extends RemoteDataBaseState {}

class RemoteDatabaseLoading extends RemoteDataBaseState {}

class RemoteDatabaseLoaded extends RemoteDataBaseState {
  final ChatSession chat;

  const RemoteDatabaseLoaded({required this.chat});

  @override
  List<Object?> get props => [chat];
}

class RemoteDatabaseError extends RemoteDataBaseState {
  final Exception errorMessage;

  const RemoteDatabaseError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
