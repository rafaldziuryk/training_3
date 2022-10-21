part of 'pokemon_detail_bloc.dart';

abstract class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();


}

class PokemonDetailInitEvent extends PokemonDetailEvent{


  final String name;

  @override
  List<Object?> get props => [name];

  const PokemonDetailInitEvent({
    required this.name,
  });
}
