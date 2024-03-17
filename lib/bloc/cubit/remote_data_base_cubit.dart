import 'package:bloc/bloc.dart';
import 'package:cinemapp/data/data.dart';
import 'package:cinemapp/data/gemini_service.dart';

import '../../main.dart';
import 'remote_data_base_state.dart';

class RemoteDataBaseInitiate extends Cubit<RemoteDataBaseState> {
  RemoteDataBaseInitiate() : super(RemoteDataBaseInitial());
  final geminiService = sl.get<GeminiService>();
  void initiate() {
    emit(RemoteDatabaseLoading());
    try {
      emit(RemoteDatabaseLoaded(chat: geminiService.chat));
    } on Exception catch (e) {
      emit(RemoteDatabaseError(errorMessage: e));
    }
  }
}
