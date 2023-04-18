import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/colors_manager.dart';
import '../../../../routing/app_router.dart';
import '../../../../routing/watching_connection.dart';
import '../controllers/recipes_controller.dart';
import 'loading_recipe_card.dart';
import 'no_recipes_screen.dart';
import 'recipe_card.dart';
import 'recipe_search_text_field.dart';

final fromCounterProvider = StateProvider<int>((ref) => 1);
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

  Future<void> connection() async {
    await Future.delayed(const Duration(seconds: 2));

    final connection = ref.watch(watchingInternetConnectionNotifierProvider);
    log(connection.toString());
    if (!connection.isLoading && connection.value != connectionStatus.initial) {
      if (connection.value == connectionStatus.connected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: ColorsManager.orange,
            content: Text('you are connected to the  internet '),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: ColorsManager.red,
            content: Text('you are not  connected to the  internet '),
          ),
        );
      }
    }
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
        -50.0; // distance from the bottom to trigger loading more recipes
    if (maxScroll - currentScroll <= delta && !ref.read(isLoadingProvider)) {
      ref.read(isLoadingProvider.notifier).update((state) => !state);
      ref.read(fromCounterProvider.notifier).update((state) => state + 1);
      await Future.delayed(const Duration(seconds: 2));
      ref.read(isLoadingProvider.notifier).update((state) => !state);
    }
  }

  @override
  Widget build(BuildContext context) {
    connection();
    final recipes = ref.watch(asyncNotifierProvider);

    // final recipes = ref.watch(
    //     fetchRecipeListProvider("${ref.watch(userSearchInputProvider)}|${ref.watch(fromCounterProvider)}"));

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleDiscoverRecipe),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
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
        child: const Text("${AppStrings.favoriteButton}  ❤"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(fromCounterProvider.notifier).update((state) => 0);
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
                                AppStrings.wrongMessage,
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
                                          ref
                                              .read(asyncNotifierProvider
                                                  .notifier)
                                              .fetchRecipes();
                                        },
                                  child: recipes.isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text(
                                          AppStrings.tryAgain,
                                          style: TextStyle(
                                              color: ColorsManager.white),
                                        ))
                            ],
                          ),
                        ),
                    data: (recipesData) {
                      log(recipesData.length.toString());
                      return recipesData.isEmpty
                          ? const SingleChildScrollView(
                              child: NoRecipesScreen())
                          : LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                              // Calculate the desired item width based on how many items you want to show
                              double itemWidth = Constant.itemWidth;

                              // Calculate the number of columns that will fit based on the available width
                              int crossAxisCount =
                                  (constraints.maxWidth / itemWidth).floor();

                              return GridView.count(
                                  controller: widget._scrollController,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  crossAxisCount: crossAxisCount,
                                  children: recipesData
                                      .map(
                                        (recipe) => InkWell(
                                          onTap: () {
                                            context.pushNamed(
                                              AppRoute.recipeDetail.name,
                                              params: {
                                                'id': recipe.id.toString()
                                              },
                                            );
                                          },
                                          child: RecipeCard(
                                            recipe: recipe,
                                          ),
                                        ),
                                      )
                                      .toList());
                            });
                    }),
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
