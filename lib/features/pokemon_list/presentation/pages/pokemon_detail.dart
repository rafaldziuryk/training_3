import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  final String name;

  const PokemonDetail({@PathParam('name') required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(name),
    );
  }
}
