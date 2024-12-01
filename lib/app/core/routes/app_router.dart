import 'package:go_router/go_router.dart';

import '../../features/characters/presenter/pages/character_details_page.dart';
import '../../features/characters/presenter/pages/characters_list_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/characters',
    routes: [
      GoRoute(
        path: '/characters',
        builder: (context, state) => const CharactersListPage(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return CharacterDetailsPage(id: id);
            },
          ),
        ],
      ),
    ],
  );
}
