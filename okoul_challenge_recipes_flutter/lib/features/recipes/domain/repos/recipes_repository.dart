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

// final fetchRecipeListProvider =
//     FutureProvider.family<List<Recipe>, String>((ref, from) async {
//   return ref
//       .read(recipeRepositoryProvider)
//       .fetchRecipeList(from: from.split("|")[1], query: from.split("|")[0]);
// });

final fetchRecipeDetailProvider =
    FutureProvider.autoDispose.family<RecipeDetails, String>((ref, id) async {
  return ref.read(recipeRepositoryProvider).fetchRecipeDetail(id: id);
});

abstract class RecipeRepository {
  Future<List<Recipe>> fetchRecipeList(
      {required String from, required String query});
  Future<RecipeDetails> fetchRecipeDetail({required String id});
}

class RecipeRepositoryImpl extends BaseAPI implements RecipeRepository {
  @override
  Future<List<Recipe>> fetchRecipeList(
      {required String from, required String query}) async {
    log((from * Constant.requestSize).toString());
    final getAddressApi = getAPI(ApiPaths.recipesList);
    final queryParameter = {
      "from": (int.parse(from) * Constant.requestSize).toString(),
      "size": Constant.requestSize.toString(),
      "q": query,
    };
    final response =
        await super.get(getAddressApi, queryParams: queryParameter);

    final resultRecipe = response["results"] as List<dynamic>;

    final List<Recipe> listRecipes =
        resultRecipe.map((recipe) => Recipe.fromMap(recipe)).toList();


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
