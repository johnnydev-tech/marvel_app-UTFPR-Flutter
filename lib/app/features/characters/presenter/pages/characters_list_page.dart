import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigator/navigator_handler.dart';
import '../../../../core/theme/app_theme_mode.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../domain/entities/character_entity.dart';
import '../providers/characters_provider.dart';
import '../states/characters_state.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  late CharactersProvider charactersProvider;
  late ThemeProvider themeProvider;
  late NavigatorHandler navigatorHandler;

  @override
  void initState() {
    super.initState();
    charactersProvider = GetIt.I<CharactersProvider>();
    navigatorHandler = GetIt.I<NavigatorHandler>();
    themeProvider = GetIt.I<ThemeProvider>();
    charactersProvider.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: charactersProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Characters"),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      iconColor: themeProvider.themeMode == AppThemeMode.system
                          ? Theme.of(context).primaryColor
                          : null,
                      leading: const Icon(Icons.auto_awesome),
                      title: const Text("System"),
                      onTap: () {
                        themeProvider.setTheme(AppThemeMode.system);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      iconColor: themeProvider.themeMode == AppThemeMode.light
                          ? Theme.of(context).primaryColor
                          : null,
                      leading: const Icon(Icons.light_mode),
                      title: const Text("Light"),
                      onTap: () {
                        themeProvider.setTheme(AppThemeMode.light);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      iconColor: themeProvider.themeMode == AppThemeMode.dark
                          ? Theme.of(context).primaryColor
                          : null,
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Dark"),
                      onTap: () {
                        themeProvider.setTheme(AppThemeMode.dark);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await charactersProvider.fetchCharacters();
          },
          child: Consumer<CharactersProvider>(
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
                      return _buildItem(character);
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
      ),
    );
  }

  Widget _buildItem(CharacterEntity character) {
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
  }
}
