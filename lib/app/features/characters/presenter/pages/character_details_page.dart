import 'package:flutter/material.dart';

import '../../domain/entities/character_entity.dart';

class CharacterDetailsPage extends StatelessWidget {
  final String id;
  final CharacterEntity character;

  const CharacterDetailsPage({
    super.key,
    required this.id,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Character Details")),
      body: Center(
        child: Text("Details for character: $id"),
      ),
    );
  }
}
