import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late final Dio dio;
  int? selectedIndex;

  @override
  void initState() {
    dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Response>(
          future: dio.get("pokemon?limit=1154&offset=0"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.data as Map;
              final results = data["results"] as List;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final element = results[index];
                  return AnimatedOpacity(
                    duration: kThemeAnimationDuration,
                    opacity: selectedIndex == index ? 1.0 : 0.8,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          if (selectedIndex == index) {
                            selectedIndex = null;
                          } else {
                            selectedIndex = index;
                          }
                        });
                      },
                      title: Text("Pokemon ${element["name"]}"),
                      leading: Image(
                          image: CachedNetworkImageProvider(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
                      )),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
