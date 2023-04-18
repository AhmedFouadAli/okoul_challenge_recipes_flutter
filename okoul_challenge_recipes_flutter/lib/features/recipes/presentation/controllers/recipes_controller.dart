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
   final result= await fetchRecipes();
    return result;
  }

  Future<List<Recipe>> fetchRecipes() async {
    final userSearch = ref.watch(userSearchInputProvider);
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => ref
        .read(recipeRepositoryProvider)
        .fetchRecipeList(
            size: ref.watch(fromCounterProvider), query: userSearch));

    if (result.hasError) {
      log("error");
      state = AsyncError(result.error!, result.stackTrace!);
    } else {
      log("no");

      state = result;
    }
    return state.value ?? [];
  }

  void clearStateForSearching() {
    ref.read(fromCounterProvider.notifier).update((state) => 1);
    state = const AsyncValue.data([]);
    ref.read(userSearchInputProvider.notifier).update((state) => "");
  }
}

final asyncNotifierProvider =
    AsyncNotifierProvider<RecipesControllerNotifier, List<Recipe>>(
        RecipesControllerNotifier.new);
