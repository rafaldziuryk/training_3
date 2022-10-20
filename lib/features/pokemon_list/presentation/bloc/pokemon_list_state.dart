part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();
}

class PokemonListInitial extends PokemonListState {
  @override
  List<Object> get props => [];
}

class PokemonListPending extends PokemonListState {
  @override
  List<Object> get props => [];
}

class PokemonListData extends PokemonListState {

  int selectedIndex;
  List<Pokemon> list;

  @override
  List<Object> get props => [list, selectedIndex];

  PokemonListData({
    required this.list,
    required this.selectedIndex
  });

}