import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/core/di/injector.dart';
import 'app/core/routes/app_router.dart';
import 'app/core/theme/theme_provider.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ThemeProvider>()..loadTheme(),
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp.router(
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeModeForMaterial,
          routerConfig: AppRouter.router,
        );
      }),
    );
  }
}
