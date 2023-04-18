// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:RecipeX/constants/app_sizes.dart';
import 'package:RecipeX/features/recipes/presentation/screens/loading_recipe_detail.dart';
import 'package:RecipeX/features/recipes/presentation/screens/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/colors_manager.dart';
import '../../../../routing/app_router.dart';
import '../../../favorite/presentation/controllers/favorite_controller.dart';
import '../../domain/models/recipe_details.dart';
import '../../domain/repos/recipes_repository.dart';

class RecipeDetailScreen extends ConsumerWidget {
  RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  final String recipeId;
  final isFavoriteProvider = StateProvider.family<bool, int>((ref, id) {
    final currentState = ref.watch(favoriteProvider);
    return currentState
        .where((element) => element.id == id)
        .toList()
        .isNotEmpty;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(fetchRecipeDetailProvider(recipeId));
    return Scaffold(
      body: recipe.when(
        data: (recipe) => CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                expandedHeight: 300,
                recipe: recipe,
              ),
              floating: true,
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(
                  AppStrings.ingredients,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorsManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return BuildCheckList(
                      title: recipe.ingredients[index].name,
                      quantity:
                          "${recipe.ingredients[index].quantity} ${recipe.ingredients[index].unit}");
                },
                childCount: recipe.ingredients.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  AppStrings.instructions,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorsManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorsManager.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          gapW12,
                          Expanded(
                            child: Text(
                              recipe.instructions[index],
                              style: const TextStyle(
                                fontSize: 15,
                                color: ColorsManager.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: recipe.instructions.length,
                ),
              ),
            ),
          ],
        ),
        error: (Object error, StackTrace stackTrace) {
          return Text(error.toString());
        },
        loading: () =>
            const SingleChildScrollView(child: LoadingRecipeDetail()),
      ),
    );
  }
}

class BuildCheckList extends ConsumerWidget {
  BuildCheckList({
    Key? key,
    required this.title,
    required this.quantity,
  }) : super(key: key);
  final String title;
  final String quantity;
  final isCheckedProvider = StateProvider<bool>((ref) {
    return false;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(isCheckedProvider);

    return SizedBox(
      child: CheckboxListTile(
        dense: true,
        checkColor: ColorsManager.white,
        activeColor: ColorsManager.backGroundApp,
        side: const BorderSide(
            color: ColorsManager.white, width: 2, style: BorderStyle.solid),
        checkboxShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        value: isChecked,
        onChanged: (bool? value) {
          ref.read(isCheckedProvider.notifier).update((state) => value!);
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2, // Limit the text to 2 lines
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decorationColor: ColorsManager.black,
                  decorationThickness: 2,
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 15,
                  color: ColorsManager.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              quantity,
              style: const TextStyle(
                fontSize: 13,
                color: ColorsManager.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            gapW16
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

class BuildReusableIcon extends StatelessWidget {
  const BuildReusableIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorsManager.backGroundApp.withAlpha(100),
      child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final RecipeDetails recipe;

  MySliverAppBar({
    required this.expandedHeight,
    required this.recipe,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: recipe.id,
          child: Image.network(
            recipe.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 33,
          left: 16,
          child: BuildReusableIcon(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorsManager.white,
            ),
            onPressed: () {
              context.pushNamed(AppRoute.recipesList.name);
            },
          ),
        ),
        Positioned(
            top: 33,
            right: 16,
            child: CircleAvatar(
                radius: 25,
                backgroundColor: ColorsManager.backGroundApp.withAlpha(100),
                child: BuildFavoriteRecipe(recipe: recipe))),
        Positioned(
            bottom: 50,
            left: 23,
            child: Text(
              recipe.title,
              style: const TextStyle(
                color: ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
        Positioned(
          bottom: 15,
          left: 23,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorsManager.white,
              ),
              child: Text('⭐ ${(recipe.rating as double).toStringAsFixed(3)}',
                  style: const TextStyle(fontSize: 15))),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 175;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
