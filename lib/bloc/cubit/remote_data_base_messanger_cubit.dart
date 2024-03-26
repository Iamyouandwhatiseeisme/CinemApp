import 'package:bloc/bloc.dart';
import 'package:cinemapp/data/data.dart';
import 'package:cinemapp/main.dart';
import 'package:equatable/equatable.dart';

part 'remote_data_base_messanger_state.dart';

class RemoteDataBaseMessangerCubit extends Cubit<RemoteDataBaseMessangerState> {
  RemoteDataBaseMessangerCubit() : super(RemoteDataBaseMessangerInitial());
  final geminiservice = sl.get<GeminiService>();
  Future<void> sendChatMessage(String message) async {
    emit(RemoteDataBaseMessangerLoading());
    try {
      final text = await geminiservice.sendChatMessage(message);
      emit(RemoteDataBaseMessangerLoaded(text: text));
    } on Exception catch (e) {
      emit(RemoteDataBaseMessangerError(errorMessage: e));
    }
  }
}
