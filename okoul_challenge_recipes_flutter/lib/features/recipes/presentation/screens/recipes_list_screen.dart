import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/colors_manager.dart';
import '../../../../routing/app_router.dart';
import '../../domain/repos/recipes_repository.dart';
import 'loading_recipe_card.dart';
import 'no_recipes_screen.dart';
import 'recipe_card.dart';
import 'recipe_search_text_field.dart';

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class RecipesListScreen extends ConsumerStatefulWidget {
  RecipesListScreen({super.key});
  final _scrollController = ScrollController();

  @override
  ConsumerState<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends ConsumerState<RecipesListScreen> {
  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() async {
    final maxScroll = widget._scrollController.position.maxScrollExtent;
    final currentScroll = widget._scrollController.position.pixels;
    const delta =
        50.0; // distance from the bottom to trigger loading more recipes
    if (maxScroll - currentScroll <= delta && !ref.read(isLoadingProvider)) {
      // Todo:Adding more item when reaching to the end
      ref.read(isLoadingProvider.notifier).update((state) => !state);
      await Future.delayed(const Duration(seconds: 2));
      ref.read(isLoadingProvider.notifier).update((state) => !state);
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(
        fetchRecipeListProvider("${ref.watch(userSearchInputProvider)}|0"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Recipes '),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          searchFieldController.clear();
          ref.invalidate(userSearchInputProvider);

          context.pushNamed(AppRoute.favoritesList.name);
        },
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
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(fetchRecipeListProvider(
              "${ref.watch(userSearchInputProvider)}|0"));
        },
        child: Container(
          padding:
              const EdgeInsets.only(top: 0, left: 13, right: 13, bottom: 10),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Something went wrong\n',
                          style: TextStyle(
                              fontSize: 20, color: ColorsManager.white),
                        ),
                        Text(
                          "$error\n",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: ColorsManager.white),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorsManager.black),
                              foregroundColor: MaterialStateProperty.all(
                                  ColorsManager.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                            ),
                            onPressed: recipes.isLoading
                                ? null
                                : () {
                                    ref.invalidate(fetchRecipeListProvider(
                                        "${ref.watch(userSearchInputProvider)}|0"));
                                  },
                            child: recipes.isLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    "Try again",
                                    style:
                                        TextStyle(color: ColorsManager.white),
                                  ))
                      ],
                    ),
                  ),
                  data: (recipes) => recipes.isEmpty
                      ? const SingleChildScrollView(child: NoRecipesScreen())
                      : GridView.count(
                          controller: widget._scrollController,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          crossAxisCount: 2,
                          children: recipes
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
              ),
              if (ref.watch(isLoadingProvider))
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(13.0),
                  child: CircularProgressIndicator(),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
