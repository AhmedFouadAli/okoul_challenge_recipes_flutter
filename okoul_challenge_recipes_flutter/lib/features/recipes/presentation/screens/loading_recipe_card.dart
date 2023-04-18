// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/colors_manager.dart';

class LoadingRecipeCard extends StatelessWidget {
  const LoadingRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.baseColor,
      highlightColor: ColorsManager.highlightColor,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the desired item width based on how many items you want to show
          double itemWidth = Constant.itemWidth;

          // Calculate the number of columns that will fit based on the available width
          int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          return GridView.count(
              crossAxisCount: crossAxisCount,
              children: List.generate(
                  30,
                  (index) => Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const SizedBox(height: 300),
                      )));
        },
      ),
    );
  }
}
