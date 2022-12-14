// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    PokemonListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PokemonList(),
      );
    },
    PokemonDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<PokemonDetailRouteArgs>(
          orElse: () => PokemonDetailRouteArgs(
                name: pathParams.getString('name'),
                index: queryParams.optInt('index'),
              ));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PokemonDetail(
          name: args.name,
          key: args.key,
          index: args.index,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/pokemon',
          fullMatch: true,
        ),
        RouteConfig(
          PokemonListRoute.name,
          path: '/pokemon',
        ),
        RouteConfig(
          PokemonDetailRoute.name,
          path: '/pokemon/:name',
        ),
      ];
}

/// generated route for
/// [PokemonList]
class PokemonListRoute extends PageRouteInfo<void> {
  const PokemonListRoute()
      : super(
          PokemonListRoute.name,
          path: '/pokemon',
        );

  static const String name = 'PokemonListRoute';
}

/// generated route for
/// [PokemonDetail]
class PokemonDetailRoute extends PageRouteInfo<PokemonDetailRouteArgs> {
  PokemonDetailRoute({
    required String name,
    Key? key,
    required int? index,
  }) : super(
          PokemonDetailRoute.name,
          path: '/pokemon/:name',
          args: PokemonDetailRouteArgs(
            name: name,
            key: key,
            index: index,
          ),
          rawPathParams: {'name': name},
          rawQueryParams: {'index': index},
        );

  static const String name = 'PokemonDetailRoute';
}

class PokemonDetailRouteArgs {
  const PokemonDetailRouteArgs({
    required this.name,
    this.key,
    required this.index,
  });

  final String name;

  final Key? key;

  final int? index;

  @override
  String toString() {
    return 'PokemonDetailRouteArgs{name: $name, key: $key, index: $index}';
  }
}
