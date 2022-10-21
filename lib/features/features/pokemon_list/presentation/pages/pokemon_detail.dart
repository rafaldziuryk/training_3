import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/pokemon_list/presentation/bloc/detail/pokemon_detail_bloc.dart';

const imageFactor = 0.8;
const avoidUseUndefinedIndexPrefix = 100000;

//ignore_for_file:no-magic-number
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
        backgroundColor: const Color(0xFFFC6D6E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          //ignore:no-empty-block
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))],
          //ignore:no-empty-block
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Chip(
                                    label: const Text(
                                      "Fire",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    shadowColor: Colors.red,
                                    backgroundColor: const Color(0xFFFC6D6E).withAlpha(110),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Chip(
                                    label: const Text(
                                      "Poison",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    shadowColor: Colors.red,
                                    backgroundColor: const Color(0xFFFC6D6E).withAlpha(110),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "#007",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                            color: Colors.white,
                          ),
                          height: 160,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(32),
                        child: Hero(
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
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(children: [
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                      Row(children: const [Text("aaa")]),
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
