import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/auth_bloc.dart';

class SessionInformation extends StatelessWidget {
  const SessionInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) {
            if(previous is AuthLogIn && current is AuthLogIn){
              final previousLogoutTime = previous.time;
              var previousDifference = previousLogoutTime.difference(DateTime.now()).inSeconds;
              final currentLogoutTime =  current.time;
              var  currentDifference =  currentLogoutTime.difference(DateTime.now()).inSeconds;
              return previousDifference != currentDifference;
            }else
              return false;

          },
          builder: (context, state) {
            if (state is AuthLogIn) {
              final logoutTime = state.time;
              var difference = logoutTime.difference(DateTime.now());
              return Text(difference.inSeconds.toString());
            }
            return Text("No time");
          },
        );
      },
    );
  }
}
