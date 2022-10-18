import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int index;

  @HiveField(1)
  final String name;

  const Pokemon({
    required this.index,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
    };
  }

  factory Pokemon.fromMap({required Map<String, dynamic> map, required int index}) {
    return Pokemon(
      name: map['name'] as String,
      index: index,
    );
  }


}