import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../features/recipes/presentation/screens/recipes_list_screen.dart';
import 'not_found_screen.dart';

enum AppRoute {
  homePage,
}

final GoRoterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.homePage.name,
        builder: (context, state) => const RecipesListScreen(),
      ),
    ],
  );
});
