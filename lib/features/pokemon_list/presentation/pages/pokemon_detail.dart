import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/pokemon_list/presentation/bloc/detail/pokemon_detail_bloc.dart';
import 'package:weather/features/shared/widgets/session_information.dart';

const imageFactor = 0.8;
const avoidUseUndefinedIndexPrefix = 100000;

class PokemonDetail extends StatelessWidget {
  final String name;
  final int? index;

  const PokemonDetail({
    @PathParam('name') required this.name,
    Key? key,
    @QueryParam('index') required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailBloc()..add(PokemonDetailInitEvent(name: name)),
      child: Scaffold(
        appBar: AppBar(title: const SessionInformation()),
        body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
          builder: (context, state) {
            return Column(
              children: [
                Hero(
                  tag: "${name}_image",
                  child: Image(
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.width * imageFactor,
                    width: MediaQuery.of(context).size.width * imageFactor,
                    image: CachedNetworkImageProvider(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index ?? avoidUseUndefinedIndexPrefix + 1}.png",
                    ),
                    errorBuilder: (context, error, stackTrace) => const Text("No image"),
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
