// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/assets_manager.dart';
import '../../../../constants/colors_manager.dart';

class NoFavoritesScreen extends ConsumerWidget {
  const NoFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(ImagesManager.noFavoriteIcon),
      gapH20,
      const Text(
        AppStrings.noFavorite,
        style: TextStyle(
          color: ColorsManager.white,
          fontSize: 20,
        ),
      ),
      gapH4,
      const Text(
        AppStrings.findMoreRecipe,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsManager.white,
          fontSize: 20,
        ),
      ),
      gapH12,
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorsManager.orange),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () {
            context.pop();
          },
          child: const Text(AppStrings.discoverRecipe))
    ]);
  }
}
