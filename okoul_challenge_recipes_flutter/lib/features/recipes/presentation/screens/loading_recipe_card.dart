// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingRecipeCard extends StatelessWidget {
  const LoadingRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xff717171),
      highlightColor: const Color(0xff9E9E9E),
      child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
              30,
              (index) => Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SizedBox(height: 300),
                  ))),
    );
  }
}
