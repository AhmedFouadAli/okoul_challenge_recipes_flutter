// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:RecipeX/features/recipes/domain/models/recipe.dart';

class RecipeDetails extends Recipe {
  final List<String> ingredients;
  final List<String> instructions;
  RecipeDetails({
    required this.ingredients,
    required this.instructions,
    required title,
    required imageUrl,
    required rating,
    required id,
  }) : super(title: title, imageUrl: imageUrl, rating: rating,id:id);
}
