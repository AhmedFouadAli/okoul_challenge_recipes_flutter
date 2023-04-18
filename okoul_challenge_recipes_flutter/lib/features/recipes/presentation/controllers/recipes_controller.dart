import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/recipe.dart';
import '../../domain/repos/recipes_repository.dart';
import '../screens/recipe_search_text_field.dart';
import '../screens/recipes_list_screen.dart';

class RecipesControllerNotifier extends AsyncNotifier<List<Recipe>> {
  @override
  FutureOr<List<Recipe>> build() async {
    final result = await fetchRecipes();
    return result;
  }

  Future<List<Recipe>> fetchRecipes() async {
    final userSearch = ref.watch(userSearchInputProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref
        .read(recipeRepositoryProvider)
        .fetchRecipeList(
            size: ref.watch(fromCounterProvider),
            query: ref.watch(userSearchInputProvider)));

    return state.value!;
  }

  void clearStateForSearching() {
    state = const AsyncValue.data([]);
    ref.read(userSearchInputProvider.notifier).update((state) => "");
    ref.read(fromCounterProvider.notifier).update((state) => 0);
  }
}

final asyncNotifierProvider =
    AsyncNotifierProvider<RecipesControllerNotifier, List<Recipe>>(
        RecipesControllerNotifier.new);
