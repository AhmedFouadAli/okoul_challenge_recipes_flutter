// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:RecipeX/features/recipes/domain/models/recipe.dart';

import 'ingredient.dart';

class RecipeDetails extends Recipe {
  final List<Ingredient> ingredients;
  final List<String> instructions;

  RecipeDetails({
    required this.ingredients,
    required this.instructions,
    required String title,
    required String imageUrl,
    required double rating,
    required int id,
  }) : super(
          title: title,
          imageUrl: imageUrl,
          rating: rating,
          id: id,
        );

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ingredients': ingredients,
      'instructions': instructions,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'id': id,
    };
  }

  factory RecipeDetails.fromMap(Map<String, dynamic> map) {
    // Check the "sections" key in the map to see if it contains a list of 1 or 2 items.
// If it does, get the length of the list and use it to access the last item.
// Note: This assumes that you always want to access the last item in the "sections" list.
// If you want to access a specific item, modify this code accordingly.
// Also, add error handling code in case the "sections" key is not present in the map,
// or if it is not a list.
    final int sections = (map["sections"] as List<dynamic>).length;
    return RecipeDetails(
      ingredients: List<Ingredient>.from(
          (map["sections"][sections - 1]["components"] as List<dynamic>)
              .map((IngredientItem) => Ingredient.fromJson(IngredientItem))),
      instructions: List<String>.from(((map['instructions'] as List<dynamic>)
          .map((instruction) => instruction["display_text"]))),
      id: map['id'] as int,
      title: map['name'] as String,
      imageUrl: map['thumbnail_url'] as String,
      rating: (map['user_ratings']?["score"] ?? 0.0) * 5.0,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RecipeDetails.fromJson(String source) =>
      RecipeDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
