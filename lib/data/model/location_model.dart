class LocationModel {
  final double longitude;
  final double latitude;
  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  LocationModel({required this.latitude, required this.longitude});
}
