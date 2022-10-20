import 'package:dio/dio.dart';
import 'package:weather/features/pokemon_list/data/models/pokemon_model.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';

class PokemonRemoteDatasource {

  final Dio dio;

  const PokemonRemoteDatasource({
    required this.dio,
  });

  Future<List<Pokemon>> getPokemons() async {
    return dio.get("pokemon?limit=1154&offset=0").then((snapshot) async {
      final data = snapshot.data as Map;
      final results = data["results"] as List;

      final map = results.asMap().entries.map((entry) => PokemonModel.fromMap(
        index: entry.key,
        map: entry.value,
      ));

      return map.toList();
    });
  }
}