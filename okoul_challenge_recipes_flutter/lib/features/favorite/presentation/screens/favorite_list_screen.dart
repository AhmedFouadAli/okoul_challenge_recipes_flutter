import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/colors_manager.dart';
import '../../../../routing/app_router.dart';
import '../../../recipes/domain/models/recipe.dart';
import '../../../recipes/presentation/screens/recipe_card.dart';
import '../../../recipes/presentation/screens/recipe_detail.dart';
import '../controllers/favorite_controller.dart';
import 'no_favorite_screen.dart';
import 'recipe_search_favorite.dart';

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class FavoriteListScreen extends ConsumerWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Recipe> favoriteRecipes = ref.watch(favoriteBySearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes  '),
        leading: BuildReusableIcon(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: ColorsManager.white,
          ),
          onPressed: () {
            context.pushNamed(AppRoute.recipesList.name);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 13, right: 13, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RecipesSearchFavorite(),
            gapH20,
            Expanded(
              child: favoriteRecipes.isEmpty
                  ? const Center(
                      child: SingleChildScrollView(child: NoFavoritesScreen()))
                  : GridView.count(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      crossAxisCount: 2,
                      children: favoriteRecipes
                          .map(
                            (recipe) => InkWell(
                              onTap: () {
                                context.pushNamed(
                                  AppRoute.recipeDetail.name,
                                  params: {'id': recipe.id.toString()},
                                );
                              },
                              child: RecipeCard(
                                recipe: recipe,
                              ),
                            ),
                          )
                          .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
