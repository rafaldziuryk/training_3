import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pokemon.dart';

class DiContainer {
  Future<void> registerDependency() async {
    final dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/"));

    await GetIt.instance.reset(dispose: true);
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(PokemonAdapter().typeId)) {
      Hive.registerAdapter(PokemonAdapter());
    }

    final Box<Pokemon> box = await Hive.openBox('pokemonBox');

    GetIt.instance.registerSingleton(dio);
    GetIt.instance.registerSingleton<Box<Pokemon>>(box);
  }
}