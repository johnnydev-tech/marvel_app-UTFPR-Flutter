import 'package:flutter/material.dart';

class CharacterDetailsPage extends StatelessWidget {
  final String id;

  const CharacterDetailsPage({super.key, required this.id});

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
