import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) {
      print("Event $event");
      emit(AuthLogOut());
    });

    on<AuthLoginEvent>((event, emit) {
      print("Event $event");
      emit(AuthLogIn());

      Future.delayed(Duration(seconds: 10), () => add(AuthLogoutEvent()));
    });

    on<AuthLogoutEvent>((event, emit) {
      print("Event $event");
      emit(AuthLogOut());
    });
  }
}
