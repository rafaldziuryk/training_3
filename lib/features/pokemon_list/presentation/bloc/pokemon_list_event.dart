part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object?> get props => [];
}

class PokemonListInitEvent extends PokemonListEvent {
}

class PokemonListToggleSelectEvent extends PokemonListEvent {
  final int selectedIndex;

  const PokemonListToggleSelectEvent({
    required this.selectedIndex,
  });
}

class PokemonListToggleLikedEvent extends PokemonListEvent {
  final Pokemon pokemon;

  const PokemonListToggleLikedEvent({
    required this.pokemon,
  });
}

class PokemonListSearchEvent extends PokemonListEvent {
  final String filter;

  const PokemonListSearchEvent({
    required this.filter,
  });
}