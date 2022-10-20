import 'package:weather/core/use_case.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/domain/repositories/pokemon_repository.dart';

import '../../../../core/fail.dart';

class GetPokemonsUseCase extends UseCase<List<Pokemon>, NoParams> {
  final PokemonRepository pokemonRepository;

  @override
  Future<UseCaseResult<Fail, List<Pokemon>>> call(NoParams params) async {
    final localResult = await pokemonRepository.getPokemonsFromLocal();
    if (localResult.isSuccess) {
      final data = localResult.data;
      if (data.isNotEmpty) {
        return localResult;
      }
    }

    final result = await pokemonRepository.getPokemonsFromRemote();
    if (result.isSuccess) {
      final data = result.data;
      final saveToLocalResult = await pokemonRepository.savePokemonsToLocal(data);

      if (saveToLocalResult.isSuccess) {
        return result;
      } else {
        return UseCaseResult.error(saveToLocalResult.failure);
      }
    } else {
      return result;
    }
  }

  const GetPokemonsUseCase({
    required this.pokemonRepository,
  });
}
