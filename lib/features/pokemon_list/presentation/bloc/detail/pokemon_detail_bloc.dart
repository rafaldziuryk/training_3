import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc() : super(PokemonDetailInitial()) {
    on<PokemonDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
