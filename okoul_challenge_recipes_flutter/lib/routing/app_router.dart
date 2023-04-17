import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../features/favorite/presentation/screens/favorite_list_screen.dart';
import '../features/recipes/presentation/screens/recipe_detail.dart';
import '../features/recipes/presentation/screens/recipes_list_screen.dart';
import 'not_found_screen.dart';

enum AppRoute {
  recipesList,
  favoritesList,
  recipeDetail,
}

final GoRoterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.recipesList.name,
        builder: (context, state) => RecipesListScreen(),
      ),
      GoRoute(
        path: '/favorite',
        name: AppRoute.favoritesList.name,
        builder: (context, state) => FavoriteListScreen(),
      ),
      GoRoute(
          path: '/recipeDetail/:id',
          name: AppRoute.recipeDetail.name,
          builder: (context, state) {
            log(state.params.toString());
            final recipeId = state.params['id']!;
            log(recipeId);
            return RecipeDetailScreen(recipeId: recipeId);
          }),
    ],
  );
});
