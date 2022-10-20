part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
