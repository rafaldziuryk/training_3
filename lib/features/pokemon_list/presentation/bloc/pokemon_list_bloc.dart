import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/use_case.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/domain/use_case/get_pokemons_use_case.dart';

part 'pokemon_list_event.dart';

part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final GetPokemonsUseCase getPokemonUseCase;
  int selectedIndex = -1;
  List<Pokemon> pokemons = [];

  PokemonListBloc({
    required this.getPokemonUseCase,
  }) : super(PokemonListInitial()) {
    on<PokemonListInitEvent>((event, emit) async {
      emit(PokemonListPending());
      final result = await getPokemonUseCase(NoParams());

      if (result.isSuccess) {
        pokemons = result.data;
        emit(PokemonListData(list: pokemons, selectedIndex: selectedIndex));
      }
    });

    on<PokemonListToggleSelectEvent>((event, emit) async {
      if (event.selectedIndex == selectedIndex) {
        selectedIndex = -1;
      } else {
        selectedIndex = event.selectedIndex;
      }

      emit(PokemonListData(list: (state as PokemonListData).list, selectedIndex: selectedIndex));
    });

    on<PokemonListSearchEvent>((event, emit) async {
      emit(PokemonListData(
        list: pokemons.where((element) => element.name.contains(event.filter)).toList(),
        selectedIndex: selectedIndex,
      ));
    });
  }
}
