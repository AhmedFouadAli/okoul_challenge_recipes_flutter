// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final dynamic rating;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  Recipe copyWith({
    String? title,
    String? imageUrl,
    double? rating,
  }) {
    return Recipe(
      id: id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': title,
      'thumbnail_url': imageUrl,
      'rating': rating,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      title: map['name'] as String,
      imageUrl: map['thumbnail_url'] as String,
      rating: double.parse(((map['user_ratings']?["score"] ?? 0.0) * 5.0 as double).toStringAsFixed(2)),
    );
  }
  factory Recipe.fromMapFavorite(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int,
      title: map['name'] as String,
      imageUrl: map['thumbnail_url'] as String,
      rating: (map['rating'] as double),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Recipe.fromJsonFavorite(String source) =>
      Recipe.fromMapFavorite(json.decode(source) as Map<String, dynamic>);



  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, imageUrl: $imageUrl, rating: $rating)';
  }
}
