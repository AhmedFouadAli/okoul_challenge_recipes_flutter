// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/recipes/domain/models/recipe.dart';

class AppPreferences {
  final SharedPreferences sharedPreferences;
  AppPreferences({
    required this.sharedPreferences,
  });

  static const String _favorites = 'favorites';

  Future<bool> setFavorites(String updatedFavorite) async {
    print(updatedFavorite);
    return await sharedPreferences.setString(_favorites, updatedFavorite);
  }

  List<Recipe> getFavorites() {
    String? favorites = sharedPreferences.getString(_favorites);
    if (favorites != null) {

      return (jsonDecode(favorites) as List<dynamic>)
          .map((e) => Recipe.fromJsonFavorite(e))
          .toList();
    }
    return [];
  }
}

final sharedPreferencesProvider = Provider<AppPreferences>((ref) {
  throw UnimplementedError();
});
