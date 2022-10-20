import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/features/pokemon_list/domain/entities/pokemon.dart';

part 'pokemon_model.g.dart';

@HiveType(typeId: 1)
class PokemonModel extends Pokemon {
  @override
  @HiveField(0)
  final int index;

  @override
  @HiveField(1)
  final String name;


  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory PokemonModel.fromMap({required Map<String, dynamic> map, required int index}) {
    return PokemonModel(
      name: map['name'] as String,
      index: index,
    );
  }

  PokemonModel({
    required this.index,
    required this.name,
  });
}