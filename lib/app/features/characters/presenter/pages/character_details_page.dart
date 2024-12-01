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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: character.id,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      character.thumbnail,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black87, Colors.black12],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Expanded(
                    child: Text(
                      character.name,
                      style: context.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.description_outlined,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          character.description,
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
