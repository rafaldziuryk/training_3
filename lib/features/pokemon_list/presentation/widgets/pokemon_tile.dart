import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';
import 'package:weather/features/pokemon_list/presentation/bloc/pokemon_list_bloc.dart';

const _imageSelectedHeight = 100.0;
const _imageDeselectedHeight = 60.0;
const _tileSelectedOpacity = 1.0;
const _tileDeselectedOpacity = 0.5;

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
      onTap: () => BlocProvider.of<PokemonListBloc>(context).add(PokemonListToggleSelectEvent(selectedIndex: index)),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isSelected ? _imageSelectedHeight : _imageDeselectedHeight,
        color: Colors.white,
        child: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: isSelected ? _tileSelectedOpacity : _tileDeselectedOpacity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Hero(
                  tag:"${element.name}_image",
                  child: Image(
                    image: CachedNetworkImageProvider(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${element.index + 1}.png",
                    ),
                    errorBuilder: (context, error, stackTrace) => const Text("No image"),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Pokemon ${element.name}",
                    textAlign: TextAlign.center,
                  ),
                ),
                AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: isSelected ? 1 : 0,
                  child: IconButton(
                    onPressed: () => AutoRouter.of(context).pushNamed("/pokemon/${element.name}?index=${element.index + 1}"),
                    icon: const Icon(Icons.arrow_downward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
