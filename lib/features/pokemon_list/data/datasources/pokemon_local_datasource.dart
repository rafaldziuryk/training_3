import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';

class PokemonLocalDatasource {
  final Box<Pokemon> pokemonsBox;

  Future save(List<Pokemon> pokemons) async {
    await pokemonsBox.clear();
    pokemonsBox.putAll(pokemons.asMap().map((key, value) => MapEntry(value.index, value)));
  }

  Future<List<Pokemon>> read() async {
    return pokemonsBox.values.toList();
  }

  const PokemonLocalDatasource({
    required this.pokemonsBox,
  });

  Pokemon getPokemonFromName(String name) {
    return pokemonsBox.values.firstWhere((element) => element.name == name);
  }

  Future update(Pokemon pokemon) async {
    pokemonsBox.putAt(pokemon.index, pokemon);
  }
}