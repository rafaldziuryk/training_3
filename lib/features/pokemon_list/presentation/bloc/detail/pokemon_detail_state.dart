part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();
}

class PokemonDetailInitial extends PokemonDetailState {
  @override
  List<Object> get props => [];
}
