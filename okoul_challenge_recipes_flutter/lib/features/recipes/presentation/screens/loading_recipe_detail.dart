import 'package:RecipeX/constants/app_sizes.dart';
import 'package:RecipeX/constants/app_string.dart';
import 'package:RecipeX/constants/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingRecipeDetail extends StatelessWidget {
  const LoadingRecipeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH16,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Shimmer.fromColors(
            baseColor: ColorsManager.baseColor,
            highlightColor: ColorsManager.highlightColor,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Shimmer(
            direction: ShimmerDirection.ltr,
            period: Duration(milliseconds: 1500),
            gradient: LinearGradient(colors: [
              ColorsManager.baseColor,
              ColorsManager.highlightColor,
              ColorsManager.baseColor
            ]),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: 6,
            separatorBuilder: (context, index) => gapH16,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: ColorsManager.baseColor,
                highlightColor: ColorsManager.highlightColor,
                child: const BuildLoadingIngredientItem(),
              );
            },
          ),
        ),
        gapH16,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Shimmer(
            direction: ShimmerDirection.ltr,
            period: Duration(milliseconds: 1500),
            gradient: LinearGradient(colors: [
              ColorsManager.baseColor,
              ColorsManager.highlightColor,
              ColorsManager.baseColor
            ]),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: 6,
            separatorBuilder: (context, index) => gapH16,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: ColorsManager.baseColor,
                highlightColor: ColorsManager.highlightColor,
                child: const BuildInstructionLoadingItem(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BuildInstructionLoadingItem extends StatelessWidget {
  const BuildInstructionLoadingItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.baseColor,
      highlightColor: ColorsManager.highlightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsManager.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          gapW12,
          gapW24,
          Container(
            height: 20,
            width: 300,
            decoration: BoxDecoration(
              color: ColorsManager.black,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildLoadingIngredientItem extends StatelessWidget {
  const BuildLoadingIngredientItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        gradient: const LinearGradient(colors: [
          ColorsManager.baseColor,
          ColorsManager.highlightColor,
          ColorsManager.baseColor
        ]),
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 1500),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorsManager.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            gapW24,
            Container(
              height: 20,
              width: 260,
              decoration: BoxDecoration(
                color: ColorsManager.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            gapW24,
            Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                color: ColorsManager.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ));
  }
}
