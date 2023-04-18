// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/assets_manager.dart';
import '../../../../constants/colors_manager.dart';
import 'recipe_search_text_field.dart';

class NoRecipesScreen extends ConsumerWidget {
  const NoRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(ImagesManager.searchIcon),
      gapH20,
      const Text(
        AppStrings.noResult,
        style: TextStyle(
          color: ColorsManager.white,
          fontSize: 20,
        ),
      ),
      gapH4,
      const Text(
        AppStrings.tryDifferentWords,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsManager.white,
          fontSize: 20,
        ),
      ),
      const Text(
        AppStrings.justClick,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsManager.grey,
          fontSize: 15,
        ),
      ),
      Wrap(

          // mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            BuildSuggestionBox(title: "chechen"),
            BuildSuggestionBox(title: "chechen"),
            BuildSuggestionBox(title: "chechen"),
            BuildSuggestionBox(title: "chechen"),
            BuildSuggestionBox(title: "chechen"),
            BuildSuggestionBox(title: "chechen"),
          ])
    ]);
  }
}

class BuildSuggestionBox extends ConsumerWidget {
  const BuildSuggestionBox({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(userSearchInputProvider.notifier).update((state) => title);
        searchFieldController.text = title;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: ColorsManager.black,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: ColorsManager.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
