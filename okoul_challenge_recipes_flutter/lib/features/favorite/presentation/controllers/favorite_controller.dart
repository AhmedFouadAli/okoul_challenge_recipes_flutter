import 'dart:convert';

import 'package:RecipeX/features/favorite/presentation/screens/recipe_search_favorite.dart';
import 'package:RecipeX/features/recipes/domain/models/recipe.dart';
import 'package:RecipeX/utils/app_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class FavoriteNotifier extends Notifier<List<Recipe>> {
  @override
  build() {
    return ref.read(sharedPreferencesProvider).getFavorites();
  }

  void _add(Recipe recipe) {
    state = [...state, recipe];
    ref
        .read(sharedPreferencesProvider)
        .setFavorites(jsonEncode(state.map((item) => item.toJson()).toList()));
  }

  void _remove(Recipe recipe) {
    state = state.where((element) => element.id != recipe.id).toList();
    ref
        .read(sharedPreferencesProvider)
        .setFavorites(jsonEncode(state.map((item) => item.toJson()).toList()));
  }

  bool _isFavorite(Recipe recipe) {
    return state
        .where((element) => element.id == recipe.id)
        .toList()
        .isNotEmpty;
  }

  void toggle(Recipe recipe) {
    if (_isFavorite(recipe)) {
      _remove(recipe);
    } else {
      _add(recipe);
    }
  }
}

final favoriteProvider =
    NotifierProvider<FavoriteNotifier, List<Recipe>>(FavoriteNotifier.new);

final favoriteBySearchProvider = Provider<List<Recipe>>((ref) {
  final searchTerm = ref.watch(userSearchFavoritesInputProvider);
  return ref
      .watch(favoriteProvider)
      .where((element) => element.title.contains(searchTerm))
      .toList();
});
