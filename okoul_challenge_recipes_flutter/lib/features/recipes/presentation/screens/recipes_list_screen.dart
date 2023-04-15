import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/colors_manager.dart';
import '../../domain/repos/recipes_repository.dart';
import 'loading_recipe_card.dart';
import 'no_recipes_screen.dart';
import 'recipe_card.dart';
import 'recipe_search_text_field.dart';

class RecipesListScreen extends ConsumerWidget {
  const RecipesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(
        fetchRecipeListProvider("${ref.watch(userSearchInputProvider)}|0"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Recipes '),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsManager.white),
          foregroundColor: MaterialStateProperty.all(ColorsManager.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
        ),
        child: const Text("Favorite ❤"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 13, right: 13, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const RecipesSearchTextField(),
            gapH20,
            Expanded(
              child: recipes.when(
                loading: () => const LoadingRecipeCard(),
                error: (error, stack) => Center(
                  child: Text(error.toString()),
                ),
                data: (recipes) => recipes.isEmpty
                    ? const SingleChildScrollView(child: NoRecipesScreen())
                    : GridView.count(
                        crossAxisCount: 2,
                        children: recipes
                            .map(
                              (recipe) => RecipeCard(
                                title: recipe.title,
                                imageLink: recipe.imageUrl,
                                rating: recipe.rating,
                                isFavorite: false,
                              ),
                            )
                            .toList()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
