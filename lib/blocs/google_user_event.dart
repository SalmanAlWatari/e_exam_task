part of 'google_user_bloc.dart';

@immutable
abstract class GoogleUserEvent {}

class SetUserEvent extends GoogleUserEvent {
  final GoogleSignInAccount? user;
  SetUserEvent({required this.user});
}

class InitialEvent extends GoogleUserEvent {
  final GoogleSignInAccount? user;
  InitialEvent({required this.user});
}
