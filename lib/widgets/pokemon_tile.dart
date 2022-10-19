import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pokemon.dart';
import '../pokemon_list_block/pokemon_list_bloc.dart';

class PokemonTile extends StatelessWidget {
  const PokemonTile({
    Key? key,
    required this.element,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  final Pokemon element;
  final bool isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PokemonListBloc>(context)
            .add(PokemonListToggleSelectEvent(selectedIndex: index));
      },
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isSelected ? 100 : 60,
        color: Colors.white,
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: isSelected ? 1.0 : 0.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image(
                  image: CachedNetworkImageProvider(
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${element.index + 1}.png",
                  ),
                  errorBuilder: (context, error, stackTrace) =>
                      Text("No image"),
                ),
                Expanded(
                    child: Text(
                  "Pokemon ${element.name}",
                  textAlign: TextAlign.center,
                )),
                AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: isSelected ? 1 : 0,
                  child: IconButton(onPressed: () {
                      AutoRouter.of(context).pushNamed("/pokemon/${element.name}");
                  }, icon: Icon(Icons.arrow_downward)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
