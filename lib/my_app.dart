import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/pokemon_list/presentation/pages/pokemon_detail.dart';

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
          return BlocBuilder<AuthBloc, AuthState>(
            buildWhen: checkIfBuildNeeded,
            builder: (context, state) {
              if (state is AuthLogIn) {
                final appRouter = AppRouter();

                return Listener(
                  onPointerSignal: (event) => BlocProvider.of<AuthBloc>(context).add(AuthExtendSessionEvent()),
                  onPointerHover: (event) => BlocProvider.of<AuthBloc>(context).add(AuthExtendSessionEvent()),
                  onPointerMove: (event) => BlocProvider.of<AuthBloc>(context).add(AuthExtendSessionEvent()),
                  child: MouseRegion(
                    onHover: (event) => BlocProvider.of<AuthBloc>(context).add(AuthExtendSessionEvent()),
                    child: MaterialApp.router(
                      routerDelegate: AutoRouterDelegate(
                        appRouter,
                      ),
                      routeInformationParser: appRouter.defaultRouteParser(),
                    ),
                  ),
                );
              } else {
                return const MaterialApp(
                  home: PokemonDetail(name: "Pikachu", index: 25),
                );
              }
            },
          );
        },
      ),
    );
  }

  bool checkIfBuildNeeded(AuthState previous, AuthState current) => previous.runtimeType != current.runtimeType;
}
