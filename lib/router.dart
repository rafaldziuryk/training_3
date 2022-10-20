import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/pokemon_list/presentation/pages/pokemon_detail.dart';
import 'package:weather/features/pokemon_list/presentation/pages/pokemon_list.dart';

part 'router.gr.dart';

@CustomAutoRouter(
    routes: <AutoRoute>[
      MaterialRoute(page: PokemonList, path: "/pokemon", initial: true),
      MaterialRoute(page: PokemonDetail, path: "/pokemon/:name")
    ])
class AppRouter extends _$AppRouter{

}
