import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:tour/data/model/location_model.dart';

import '../../shared/global/global_var.dart';

class LocationService {
  final Location _location = Location();
  late PermissionStatus _permissionStatus;
  Future<LocationModel> getCoordinates() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      await _location.requestPermission().then((value) async {
        if (value == PermissionStatus.granted) {
          await _location.getLocation().then((value) {
            currentLocation = LocationModel(
              latitude: value.latitude ?? 0.0,
              longitude: value.longitude ?? 0.0,
            );
          });
        }
      });
    } else {
      await _location.getLocation().then((value) {
        currentLocation = LocationModel(
          latitude: value.latitude ?? 0.0,
          longitude: value.longitude ?? 0.0,
        );
      });
    }
    return currentLocation;
  }

  Future<String> getCityAndCountry() async {
    String city = '';
    String country = '';
    await getCoordinates().then((value) async {
      if (value.latitude == 0.0 || value.longitude == 0.0) {
        city + country;
      } else {
        await geo
            .placemarkFromCoordinates(value.latitude, value.longitude)
            .then((value) {
          for (geo.Placemark placemark in value) {
            city = placemark.administrativeArea ?? '';
            country = placemark.country ?? '';
          }
        });
      }
    });
    return '$city, $country';
  }
}
