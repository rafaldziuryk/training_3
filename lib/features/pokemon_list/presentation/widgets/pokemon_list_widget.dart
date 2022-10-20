import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_tile.dart';

class PokemonListWidget extends StatelessWidget {
  const PokemonListWidget({
    required this.pokemons,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokemons;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemons.length, // filtered.length,
      itemBuilder: (context, index) {
        final element = pokemons[index];

        return PokemonTile(
          element: element,
          index: index,
          isSelected: selectedIndex == index,
        );
      },
    );
  }
}
