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
                CharactersLoaded() => SafeArea(
                    child: GridView.builder(
                      itemCount: state.characters.length,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return _buildItem(character);
                      },
                    ),
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
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        child: Stack(
          children: [
            Hero(
              tag: character.id,
              child: Ink(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(character.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  character.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
