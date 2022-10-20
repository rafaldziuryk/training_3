import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/splash_screen.dart';

import 'app_router.dart';
import 'auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthLogIn) {
              final appRouter = AppRouter();

              return MaterialApp.router(
                routerDelegate: AutoRouterDelegate(
                  appRouter,
                ),
                routeInformationParser: appRouter.defaultRouteParser(),
              );
            } else {
              return const MaterialApp(
                home: SplashScreen(),
              );
            }
          });
        },
      ),
    );
  }
}
