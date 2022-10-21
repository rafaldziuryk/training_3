import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';
import 'package:weather/features/pokemon_list/presentation/widgets/pokemon_list_widget.dart';
import 'package:weather/features/shared/widgets/session_information.dart';

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
      create: (context) => PokemonListBloc(getPokemonUseCase: GetIt.instance.get())..add(PokemonListInitEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const SessionInformation(),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) =>
                          BlocProvider.of<PokemonListBloc>(context).add(PokemonListSearchEvent(filter: value)),
                    ),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.clear),
                    onPressed: () => onSearchClean(context),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<PokemonListBloc, PokemonListState>(
                  builder: (context, state) {
                    if (state is PokemonListInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PokemonListPending) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PokemonListData) {
                      return PokemonListWidget(
                        pokemons: state.list,
                        selectedIndex: state.selectedIndex,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void onSearchClean(BuildContext context) {
    editingController.clear();
    BlocProvider.of<PokemonListBloc>(context).add(
      PokemonListSearchEvent(filter: editingController.text),
    );
  }
}
