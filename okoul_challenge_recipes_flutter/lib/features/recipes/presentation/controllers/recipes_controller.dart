import 'dart:async';
import 'dart:developer';

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
    print("Run - ${ref.watch(fromCounterProvider).toString()}");
    final userSearch = ref.watch(userSearchInputProvider);
    state = const AsyncLoading<List<Recipe>>().copyWithPrevious(state);
    final result = await AsyncValue.guard(() => ref
        .read(recipeRepositoryProvider)
        .fetchRecipeList(
            from: userSearch.isEmpty
                ? ref.watch(fromCounterProvider).toString()
                : "0",
            query: ref.watch(userSearchInputProvider)));

    if (!result.hasError) {
      final List<Recipe> recipes = [
        if (userSearch.isEmpty) ...(state.value ?? []),
        ...(result.value ?? [])
      ];
      log(recipes.length.toString());
      log("/" * 50);
      state = AsyncValue.data(recipes);
    } else {
      state = AsyncError<List<Recipe>>(result.error!, result.stackTrace!);
    }
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
