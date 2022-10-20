import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) {
      emit(AuthLogOut());
    });

    on<AuthLoginEvent>((event, emit) {
      emit(AuthLogIn());

      Future.delayed(const Duration(seconds: 10), () => add(AuthLogoutEvent()));
    });

    on<AuthLogoutEvent>((event, emit) {
      emit(AuthLogOut());
    });
  }
}
