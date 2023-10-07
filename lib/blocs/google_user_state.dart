part of 'google_user_bloc.dart';

abstract class GoogleUserState {
  GoogleSignInAccount? user;
  GoogleUserState({required this.user});
}

class GoogleUserInitial extends GoogleUserState {
  GoogleUserInitial({GoogleSignInAccount? user}) : super(user: user);
}

class GoogleUserUpdate extends GoogleUserState {
  GoogleUserUpdate({GoogleSignInAccount? user}) : super(user: user);
}
