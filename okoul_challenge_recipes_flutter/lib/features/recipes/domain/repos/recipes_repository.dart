import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api/api_paths.dart';
import '../../../../api/base.dart';
import '../../../../constants/app_constant.dart';
import '../models/recipe.dart';
import '../models/recipe_details.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl();
});


final fetchRecipeDetailProvider =
    FutureProvider.autoDispose.family<RecipeDetails, String>((ref, id) async {
  return ref.read(recipeRepositoryProvider).fetchRecipeDetail(id: id);
});

abstract class RecipeRepository {
  Future<List<Recipe>> fetchRecipeList(
      {required int size, required String query});
  Future<RecipeDetails> fetchRecipeDetail({required String id});
}

class RecipeRepositoryImpl extends BaseAPI implements RecipeRepository {
  @override
  Future<List<Recipe>> fetchRecipeList(
      {required int size, required String query}) async {
    final getAddressApi = getAPI(ApiPaths.recipesList);
    final queryParameter = {
      "from": "0",
      "size": (size * Constant.requestSize).toString(),
      "q": query,
    };
    final response =
        await super.get(getAddressApi, queryParams: queryParameter);
    log("The size is $size");

    final resultRecipe = response["results"] as List<dynamic>;

    final List<Recipe> listRecipes =
        resultRecipe.map((recipe) => Recipe.fromMap(recipe)).toList();

    log("the length of the result is ${listRecipes.length}");
    return listRecipes;
  }

  @override
  Future<RecipeDetails> fetchRecipeDetail({required String id}) async {
    final getAddressApi = getAPI(ApiPaths.recipeDetail);
    final queryParameter = {
      "id": id,
    };
    log("---**--" * 20);
    final response =
        await super.get(getAddressApi, queryParams: queryParameter);
    log(response.toString());

    final RecipeDetails recipe = RecipeDetails.fromMap(response);

    log(recipe.toString());

    return recipe;
  }
}
