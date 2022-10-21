import 'package:weather/core/use_case.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/domain/repositories/pokemon_repository.dart';

import '../../../../core/fail.dart';
import '../../data/models/pokemon_model.dart';

class TogglePokemonLikeUseCase extends UseCase<void, TogglePokemonUseCaseParams> {
  final PokemonRepository pokemonRepository;

  @override
  Future<UseCaseResult<Fail, void>> call(TogglePokemonUseCaseParams params) async {
    Pokemon pokemon = params.pokemon;
    pokemon = PokemonModel.fromPokemon(pokemon, !pokemon.isLiked);
    pokemonRepository.updatePokemon(pokemon);

    return UseCaseResult.success();
  }

  const TogglePokemonLikeUseCase({
    required this.pokemonRepository,
  });

}

class TogglePokemonUseCaseParams extends Params {
  final Pokemon pokemon;

  const TogglePokemonUseCaseParams({
    required this.pokemon,
  });
}
