// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../constants/colors_manager.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageLink;
  final dynamic rating;
  final bool isFavorite;

  const RecipeCard({
    Key? key,
    required this.title,
    required this.imageLink,
    required this.rating,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 160,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageLink),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
        color: ColorsManager.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.favorite_outline,
                color: ColorsManager.white,
                size: 30,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorsManager.white,
                  ),
                  child:
                      Text('⭐ $rating', style: const TextStyle(fontSize: 15))),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: ColorsManager.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
