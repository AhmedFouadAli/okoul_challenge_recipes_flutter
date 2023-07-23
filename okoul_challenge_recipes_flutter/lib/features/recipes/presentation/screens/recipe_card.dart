// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:RecipeX/constants/colors_manager.dart';
import 'package:RecipeX/features/favorite/presentation/controllers/favorite_controller.dart';
import 'package:RecipeX/features/recipes/domain/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeCard extends ConsumerWidget {
  final Recipe recipe;

  const RecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: recipe.id,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(recipe.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          color: ColorsManager.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildFavoriteRecipe(recipe: recipe),
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorsManager.white,
                    ),
                    child: Text('⭐ ${recipe.rating}',
                        style: const TextStyle(fontSize: 15))),
              ],
            ),
            Text(
              recipe.title,
              style: const TextStyle(
                color: ColorsManager.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildFavoriteRecipe extends ConsumerWidget {
  BuildFavoriteRecipe({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  final isFavoriteProvider = StateProvider.family<bool, int>((ref, id) {
    final currentState = ref.watch(favoriteProvider);
    return currentState
        .where((element) => element.id == id)
        .toList()
        .isNotEmpty;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(recipe.id));
    return IconButton(
        onPressed: () {
          ref.read(favoriteProvider.notifier).toggle(recipe);
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_outline,
          color: isFavorite ? ColorsManager.red : ColorsManager.white,
          size: 30,
        ));
  }
}
