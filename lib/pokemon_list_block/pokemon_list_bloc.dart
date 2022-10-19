import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../pokemon.dart';

part 'pokemon_list_event.dart';

part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final Dio dio;
  final Box<Pokemon> box;
  int selectedIndex = -1;

  PokemonListBloc({
    required this.dio,
    required this.box,
  }) : super(PokemonListInitial()) {
    on<PokemonListInitEvent>((event, emit) async {
      print ("Start event $event");

      emit(PokemonListPending());
      await dio.get("pokemon?limit=1154&offset=0").then((snapshot) async {
        final data = snapshot.data as Map;
        final results = data["results"] as List;

        final map = results.asMap().entries.map((entry) => Pokemon.fromMap(
              index: entry.key,
              map: entry.value,
            ));

        print("loaded GET");
        await box.clear();
        box.addAll(map);

        emit(PokemonListData(list: map.toList(), selectedIndex: selectedIndex));
      });
    });

    on<PokemonListToggleSelectEvent>((event, emit) async {
      print ("Start event $event");

      if (event.selectedIndex == selectedIndex)
        selectedIndex = -1;
      else
        selectedIndex = event.selectedIndex;

      emit(PokemonListData(list: (state as PokemonListData).list, selectedIndex: selectedIndex));
    });

    on<PokemonListSearchEvent>((event, emit) async {
      print ("Start event $event");


      emit(PokemonListData(list: box.values.where((element) => element.name.contains(event.filter)).toList(), selectedIndex: selectedIndex));
    });
  }
}
