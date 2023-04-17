class Ingredient {
  final String name;
  final String quantity;
  final String unit;

  Ingredient({required this.name, required this.quantity, required this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json["ingredient"]["name"],
      quantity: json["measurements"][0]['quantity'],
      unit: json["measurements"][0]["unit"]["name"],
    );
  }
}
