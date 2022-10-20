import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/auth/auth_bloc.dart';
import 'package:weather/di_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final diContainer = DiContainer();
    diContainer.registerDependency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Zaloguj"),
          onPressed: () => BlocProvider.of<AuthBloc>(context).add(
            AuthLoginEvent(),
          ),
        ),
      ),
    );
  }
}
