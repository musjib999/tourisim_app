class PlaceModel {
  PlaceModel({
    required this.location,
    required this.name,
    required this.image,
  });

  final String location;
  final String name;
  final String image;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        location: json["location"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "name": name,
        "image": image,
      };
}
