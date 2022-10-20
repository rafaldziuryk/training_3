import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/features/pokemon_list/data/datasources/pokemon_local_datasource.dart';
import 'package:weather/features/pokemon_list/data/datasources/pokemon_remote_datasource.dart';
import 'package:weather/features/pokemon_list/data/models/pokemon_model.dart';
import 'package:weather/features/pokemon_list/data/repositories/pokemon_repository_implementation.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/domain/repositories/pokemon_repository.dart';
import 'package:weather/features/pokemon_list/domain/use_case/get_pokemons_use_case.dart';

class DiContainer {
  Future<void> registerDependency() async {
    final di = GetIt.instance;
    final dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/"));

    await GetIt.instance.reset(dispose: true);
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(PokemonModelAdapter().typeId)) {
      Hive.registerAdapter(PokemonModelAdapter());
    }

    final Box<Pokemon> box = await Hive.openBox('pokemonBox');

    GetIt.instance.registerSingleton(dio);
    GetIt.instance.registerSingleton<Box<Pokemon>>(box);
    GetIt.instance.registerSingleton<PokemonLocalDatasource>(PokemonLocalDatasource(pokemonsBox: di.get()));
    GetIt.instance.registerSingleton<PokemonRemoteDatasource>(PokemonRemoteDatasource(dio: di.get()));
    GetIt.instance.registerSingleton<PokemonRepository>(
      PokemonRepositoryImplementation(
        localDatasource: di.get(),
        remoteDatasource: di.get(),
      ),
    );
    GetIt.instance.registerSingleton<GetPokemonsUseCase>(GetPokemonsUseCase(pokemonRepository: di.get()));
  }
}
