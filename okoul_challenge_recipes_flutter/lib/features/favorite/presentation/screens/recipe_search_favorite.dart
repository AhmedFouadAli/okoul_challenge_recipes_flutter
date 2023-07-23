// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:RecipeX/constants/app_string.dart';
import 'package:RecipeX/constants/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userSearchFavoritesInputProvider = StateProvider<String>((ref) {
  return "";
});

final searchFavoriteController = TextEditingController(text: "");

class RecipesSearchFavorite extends ConsumerWidget {
  const RecipesSearchFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: searchFavoriteController,
      cursorColor: ColorsManager.white,
      style: const TextStyle(color: ColorsManager.white),
      onChanged: (String userInput) async {
        ref
            .read(userSearchFavoritesInputProvider.notifier)
            .update((state) => userInput);
      },
      decoration: InputDecoration(
        hintText: AppStrings.hintFavoriteSearch,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: ref.watch(userSearchFavoritesInputProvider).isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  ref.invalidate(userSearchFavoritesInputProvider);
                  searchFavoriteController.clear();
                },
                icon: const Icon(Icons.close),
                color: Colors.grey),
      ),
    );
  }
}
