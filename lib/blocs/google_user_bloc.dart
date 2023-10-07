import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_user_event.dart';
part 'google_user_state.dart';

class GoogleUserBloc extends Bloc<GoogleUserEvent, GoogleUserState> {
  GoogleUserBloc() : super(GoogleUserInitial(user: null)) {
    on<SetUserEvent>(_setUser);
    on<InitialEvent>(_iniUser);
  }

  void _iniUser(InitialEvent event, Emitter<GoogleUserState> emit) {
    if (kDebugMode) {
      print("** _iniUser");
      print(state.user);
    }
    state.user = event.user;
    emit(GoogleUserUpdate(user: state.user));
  }

  void _setUser(SetUserEvent event, Emitter<GoogleUserState> emit) {
    state.user = event.user;
    if (kDebugMode) {
      print("** _setUser");
      print(state.user);
    }
    emit(GoogleUserUpdate(user: state.user));
  }
}
