import 'package:tour/core/services/service_exports.dart';

class ServiceInjector {
  LocationService locationService = LocationService();
  UtilityService utilityService = UtilityService();
  RouterService routerService = RouterService();
  FirebaseService firebaseService = FirebaseService();
  PlacesService placesService = PlacesService();
}

ServiceInjector si = ServiceInjector();
