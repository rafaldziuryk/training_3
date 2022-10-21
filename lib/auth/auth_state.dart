part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLogIn extends AuthState {
  final DateTime time;
  @override
  List<Object> get props => [time];

  const AuthLogIn({
    required this.time,
  });
}

class AuthLogOut extends AuthState {
  @override
  List<Object> get props => [];
}