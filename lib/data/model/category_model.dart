class CategoryModel {
  CategoryModel({
    required this.category,
    required this.image,
  });

  final String category;
  final String image;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "image": image,
      };
}
