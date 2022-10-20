import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';

class PokemonLocalDatasource {
  final Box<Pokemon> pokemonsBox;

  Future save(List<Pokemon> pokemons) async {
    await pokemonsBox.clear();
    pokemonsBox.addAll(pokemons);
  }

  Future<List<Pokemon>> read() async {
    return pokemonsBox.values.toList();
  }

  const PokemonLocalDatasource({
    required this.pokemonsBox,
  });
}