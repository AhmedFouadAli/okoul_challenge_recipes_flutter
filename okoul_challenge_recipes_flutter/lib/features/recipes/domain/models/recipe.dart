import 'dart:convert';

class Recipe {
  final String title;
  final String imageUrl;
  final dynamic rating;
  Recipe({
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
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      title: map['name'] as String,
      imageUrl: map['thumbnail_url'] as String,
      rating: map['user_ratings']?["score"] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) =>
      Recipe.fromMap(json.decode(source) as Map<String, dynamic>);
}
