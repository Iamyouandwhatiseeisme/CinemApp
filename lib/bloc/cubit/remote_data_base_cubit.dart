import 'package:bloc/bloc.dart';
import 'package:cinemapp/data/data.dart';
import 'package:cinemapp/main.dart';

import 'remote_data_base_state.dart';

class RemoteDataBaseInitiate extends Cubit<RemoteDataBaseState> {
  RemoteDataBaseInitiate() : super(RemoteDataBaseInitial());

  late GeminiService geminiService;

  void initiate() async {
    emit(RemoteDatabaseLoading());
    try {
      geminiService = sl.get<GeminiService>();

      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }

  void update() async {
    emit(RemoteDatabaseLoading());
    try {
      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }

  void resetChat() async {
    emit(RemoteDatabaseLoading());
    try {
      sl.resetLazySingleton<GeminiService>();
      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }

  Future<void> sendInitialChatMessage(
      {required String prefferedActor,
      required String movieLength,
      required String timePeriod,
      required String mainActorSex,
      required String prefferedAwards,
      required List<Genre> selectedGenres}) async {
    final String message =
        'Please provide me a list of 10 movies with these specifications: Preffered actor: $prefferedActor;\n time period: $timePeriod; \n length in minutes: $movieLength; \n preffered actor sex: $mainActorSex;\n preffered award/nominations: $prefferedAwards; \n genre(s): $selectedGenres; \n Please provide streaming service for each movie, if possible, provide TMDB movie id for each movie';

    emit(RemoteDatabaseLoading());
    try {
      await geminiService.sendChatMessage(message);

      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }

  Future<void> sendChatMessage({required String message}) async {
    emit(RemoteDatabaseLoading());
    try {
      await geminiService.sendChatMessage(message);
      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }
}
