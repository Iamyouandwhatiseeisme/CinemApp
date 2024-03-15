import 'package:bloc/bloc.dart';


class FloatingHintTextCubit extends Cubit<bool> {

  FloatingHintTextCubit() : super(false);


  void setFocus(bool hasFocus) => emit(hasFocus);

}

