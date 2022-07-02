import 'package:tour/data/model/location_model.dart';

class PlaceModel {
  PlaceModel({
    required this.id,
    required this.location,
    required this.name,
    required this.image,
    required this.description,
    required this.position,
  });

  final String id;
  final String location;
  final String name;
  final String image;
  final String description;
  final LocationModel position;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        id: json['id'],
        location: json["location"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        position: LocationModel.fromJson(json['position']),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "name": name,
        "image": image,
        "description": description,
        "id": id,
        "position": position.toJson()
      };
}
