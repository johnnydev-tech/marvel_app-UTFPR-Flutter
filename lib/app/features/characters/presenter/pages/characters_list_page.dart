import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigator/navigator_handler.dart';
import '../providers/characters_provider.dart';
import '../states/characters_state.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  late CharactersProvider charactersProvider;
  late NavigatorHandler navigatorHandler;

  @override
  void initState() {
    super.initState();
    charactersProvider = GetIt.I<CharactersProvider>();
    navigatorHandler = GetIt.I<NavigatorHandler>();
    charactersProvider.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: charactersProvider,
      child: Scaffold(
        appBar: AppBar(title: const Text("Characters")),
        body: Consumer<CharactersProvider>(
          builder: (context, provider, _) {
            final state = provider.state;

            return switch (state) {
              CharactersLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              CharactersLoaded() => ListView.builder(
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) {
                    final character = state.characters[index];
                    return ListTile(
                      title: Text(character.name),
                      subtitle: Text(character.description),
                      onTap: () {
                        navigatorHandler.push(
                          context,
                          "/characters/${character.id}",
                          arguments: character,
                        );
                      },
                    );
                  },
                ),
              CharactersError() => const Center(
                  child: Text("Error fetching characters"),
                ),
              _ => const Center(
                  child: Text("No data"),
                ),
            };
          },
        ),
      ),
    );
  }
}
