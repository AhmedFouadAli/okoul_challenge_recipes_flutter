// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/assets_manager.dart';
import '../../../../constants/colors_manager.dart';
import 'recipe_search_text_field.dart';

class NoRecipesScreen extends ConsumerWidget {
  const NoRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(ImagesManager.searchIcon),
        gapH20,
        const Text(
          'There is no results found',
          style: TextStyle(
            color: ColorsManager.white,
            fontSize: 20,
          ),
        ),
        gapH4,
        const Text(
          'Please try using different words. \nHere are suggestions',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsManager.white,
            fontSize: 20,
          ),
        ),
        const Text(
          'You can just click on these suggestion',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsManager.grey,
            fontSize: 15,
          ),
        ),
        Wrap(

            // mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              BuildSuggestionBox(title: "checken"),
              BuildSuggestionBox(title: "checken"),
              BuildSuggestionBox(title: "checken"),
              BuildSuggestionBox(title: "checken"),
              BuildSuggestionBox(title: "checken"),
              BuildSuggestionBox(title: "checken"),
            ])
      ]),
    );
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
        child: const Text(
          'Chicken',
          style: TextStyle(
            color: ColorsManager.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
