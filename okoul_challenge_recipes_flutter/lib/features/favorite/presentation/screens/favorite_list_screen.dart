import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_sizes.dart';
import '../../../recipes/presentation/screens/recipe_card.dart';
import '../../../recipes/presentation/screens/recipe_search_text_field.dart';
import '../controllers/favorite_controller.dart';
import 'no_favorite_screen.dart';

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class FavoriteListScreen extends ConsumerWidget {
  FavoriteListScreen({super.key});
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteRecipes = ref.watch(favoriteBySearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes  '),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 13, right: 13, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RecipesSearchTextField(
              hintText: "Search for  your favorite recipes  ",
              isFavoriteSearch: true,
            ),
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
                            (recipe) => RecipeCard(
                              recipe: recipe,
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
