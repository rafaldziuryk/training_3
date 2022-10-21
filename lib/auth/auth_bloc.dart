import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const Duration logoutTime = Duration(seconds: 30);

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  DateTime time = DateTime.now();

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) {
      emit(AuthLogOut());
    });

    on<AuthLoginEvent>((event, emit) {
      time = DateTime.now().add(logoutTime);
      emit(AuthLogIn(time: time));
      Future.delayed(logoutTime, () => add(AuthCheckLogoutEvent()));
    });

    on<AuthCheckLogoutEvent>((event, emit) {
      if (time.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        add(AuthLogoutEvent());
      }
    });

    on<AuthLogoutEvent>((event, emit) {
      emit(AuthLogOut());
    });

    on<AuthExtendSessionEvent>((event, emit) {
      time = DateTime.now().add(logoutTime);
      emit(AuthLogIn(time: time));
      Future.delayed(logoutTime, () => add(AuthCheckLogoutEvent()));
    });
  }
}
