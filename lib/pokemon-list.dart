import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pokemon.dart';
import 'package:weather/pokemon_list_block/pokemon_list_bloc.dart';
import 'package:weather/widgets/pokemon_tile.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokemonListBloc(dio: GetIt.instance.get(), box: GetIt.instance.get())
            ..add(PokemonListInitEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) {
                        BlocProvider.of<PokemonListBloc>(context)
                            .add(PokemonListSearchEvent(filter: value));
                      },
                    ),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.clear),
                    onPressed: () {
                      editingController.clear();
                      BlocProvider.of<PokemonListBloc>(context).add(
                          PokemonListSearchEvent(
                              filter: editingController.text));
                    },
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<PokemonListBloc, PokemonListState>(
                  builder: (context, state) {
                    if (state is PokemonListInitial)
                      return Center(child: CircularProgressIndicator());
                    else if (state is PokemonListPending)
                      return Center(child: CircularProgressIndicator());
                    else if (state is PokemonListData) {
                      return ListView.builder(
                        itemCount: state.list.length, // filtered.length,
                        itemBuilder: (context, index) {
                          final element =
                              state.list[index]; //  filtered.toList()[index];
                          return PokemonTile(
                            element: element,
                            index: index,
                            isSelected: state.selectedIndex == index,
                          );
                        },
                      );
                    } else
                      return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
