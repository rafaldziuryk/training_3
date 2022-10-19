import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/auth/auth_bloc.dart';
import 'package:weather/di_container.dart';
import 'package:weather/pokemon-list.dart';
import 'package:weather/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final diContainer = DiContainer();
    diContainer.registerDependency().then((value) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        //   AutoRouter.of(context).replaceNamed(PokemonListRoute().path);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(child: Text("Zaloguj"),
              onPressed: () =>
              BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent()))
      ),
    );
  }
}
