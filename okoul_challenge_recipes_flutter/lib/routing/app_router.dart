import 'dart:developer';

import 'package:RecipeX/features/favorite/presentation/screens/favorite_list_screen.dart';
import 'package:RecipeX/features/recipes/presentation/screens/recipe_detail.dart';
import 'package:RecipeX/features/recipes/presentation/screens/recipes_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

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
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.recipesList.name,
          builder: (context, state) => RecipesListScreen(),
          routes: [
            GoRoute(
              path: 'favorite',
              name: AppRoute.favoritesList.name,
              builder: (context, state) => const FavoriteListScreen(),
            ),
            GoRoute(
                path: 'recipeDetail/:id',
                name: AppRoute.recipeDetail.name,
                builder: (context, state) {
                  log(state.params.toString());
                  final recipeId = state.params['id']!;
                  log(recipeId);
                  return RecipeDetailScreen(recipeId: recipeId);
                }),
          ]),
    ],
  );
});
