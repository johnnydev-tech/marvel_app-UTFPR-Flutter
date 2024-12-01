import 'package:flutter/material.dart';

import '../../../../core/theme/extension.dart';
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
      appBar: AppBar(title: Text("Character $id")),
      body: Column(
        children: [
          Hero(
            tag: character.id,
            child: Image.network(
              character.thumbnail,
              width: double.infinity,
              height: 400,
            ),
          ),
          Text(character.name, style: context.theme.textTheme.headlineSmall),
          Text(character.description,
              style: context.theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
