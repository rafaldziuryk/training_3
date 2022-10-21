import 'package:weather/core/fail.dart';
import 'package:weather/core/use_case.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<UseCaseResult<Fail, List<Pokemon>>> getPokemonsFromRemote();
  Future<UseCaseResult<Fail, List<Pokemon>>> getPokemonsFromLocal();
  Future<UseCaseResult<Fail, void>> savePokemonsToLocal(List<Pokemon> pokemons);
  Future<UseCaseResult<Fail, Pokemon>> updatePokemon(Pokemon pokemon);
}
