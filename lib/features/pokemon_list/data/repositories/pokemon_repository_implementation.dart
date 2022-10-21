import 'package:weather/core/fail.dart';
import 'package:weather/core/use_case.dart';
import 'package:weather/features/pokemon_list/data/datasources/pokemon_local_datasource.dart';
import 'package:weather/features/pokemon_list/data/models/pokemon_model.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/domain/repositories/pokemon_repository.dart';

import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImplementation extends PokemonRepository {
  final PokemonLocalDatasource localDatasource;
  final PokemonRemoteDatasource remoteDatasource;

  @override
  Future<UseCaseResult<Fail, List<Pokemon>>> getPokemonsFromRemote() async {
    try {
      final data = await remoteDatasource.getPokemons();

      return UseCaseResult.success(data: data);
    } catch (error) {
      return UseCaseResult.error(ServerFail());
    }
  }

  @override
  Future<UseCaseResult<Fail, List<Pokemon>>> getPokemonsFromLocal() async {
    try {
      final data = await localDatasource.read();

      return UseCaseResult.success(data: data);
    } catch (error) {
      return UseCaseResult.error(LocalFail());
    }
  }

  @override
  Future<UseCaseResult<Fail, void>> savePokemonsToLocal(List<Pokemon> pokemons) async {
    try {
      await localDatasource.save(pokemons);

      return UseCaseResult.success();
    } catch (error) {
      return UseCaseResult.error(LocalFail());
    }
  }

  PokemonRepositoryImplementation({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<UseCaseResult<Fail, Pokemon>> updatePokemon(Pokemon pokemon) async {
    try {
      await localDatasource.update(pokemon);

      return UseCaseResult.success();
    } catch (error) {
      return UseCaseResult.error(LocalFail());
    }
  }
}
