import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pokemon.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late final Dio dio;
  late final Box<Pokemon> box;
  final Completer completer = Completer();
  int? selectedIndex;

  @override
  void initState() {
    dio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api/v2/"));
    super.initState();

    print("initState");
    Hive.initFlutter().then((value) async {
      print("Hive.initFlutter()");
      if (!Hive.isAdapterRegistered(PokemonAdapter().typeId)) {
        Hive.registerAdapter(PokemonAdapter());
      }
      box = await Hive.openBox('pokemonBox');
      completer.complete();
      print("initState box");
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          // box.values
          //TODO: wczytanie danych
          print("Lista z boxa");
          print(box.values);

        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: completer.future,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.done) {
            print("completer.future -> has data");
            return FutureBuilder<Iterable<Pokemon>>(
              future: box.values.isNotEmpty ? Future.value(box.values) : dio.get("pokemon?limit=1154&offset=0").then((snapshot) {
                final data = snapshot.data as Map;
                final results = data["results"] as List;

                final map = results.asMap().entries.map((entry) => Pokemon.fromMap(
                  index: entry.key,
                  map: entry.value,
                ));

                print("loaded GET");
                box.addAll(map);
                return map;
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData) {


                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final element = box.values.toList()[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = null;
                            } else {
                              selectedIndex = index;
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: kThemeAnimationDuration,
                          height: selectedIndex == index ? 100 : 60,
                          color: Colors.white,
                          child: AnimatedOpacity(
                            duration: kThemeAnimationDuration,
                            opacity: selectedIndex == index ? 1.0 : 0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image(
                                    image: CachedNetworkImageProvider(
                                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Pokemon ${element.name}",
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              });
          }
          else {
            print("completer.future -> NO data");
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
