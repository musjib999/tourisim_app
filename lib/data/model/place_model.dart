class PlaceModel {
  PlaceModel({
    required this.location,
    required this.name,
    required this.image,
    required this.description,
  });

  final String location;
  final String name;
  final String image;
  final String description;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
      location: json["location"],
      name: json["name"],
      image: json["image"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "location": location,
        "name": name,
        "image": image,
        "description": description,
      };
}
