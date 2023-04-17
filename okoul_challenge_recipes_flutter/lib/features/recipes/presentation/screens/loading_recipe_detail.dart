import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../constants/colors_manager.dart';

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
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
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
            gradient: LinearGradient(
                colors: [Colors.grey, Colors.white, Colors.grey]),
            child: Text(
              'Ingredients',
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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
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
            gradient: LinearGradient(
                colors: [Colors.grey, Colors.white, Colors.grey]),
            child: Text(
              'Instructions',
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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
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
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
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
        gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white, Colors.grey]),
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
