import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour/data/model/place_model.dart';

import '../injector.dart';

class PlacesService {
  Future addPlace({
    required String uuid,
    required String imagePath,
    required String name,
    required String location,
    String description = '',
  }) async {
    dynamic response;
    try {
      await si.firebaseService
          .savedImage(path: '/places/$uuid/$uuid.png', file: File(imagePath))
          .then(
        (value) async {
          if (value.runtimeType == String) {
            response = value;
          } else if (value.runtimeType == int) {
            int bytes = value;
            if (bytes < 1) {
              response = 'Error while uploading image';
            } else {
              String? imageUrl = await si.firebaseService
                  .getImageUrl('/places/$uuid/$uuid.png');
              await si.firebaseService
                  .addDoc(
                collection: 'places',
                data: {
                  'location': location,
                  'name': name,
                  'image': imageUrl,
                  // 'position': {
                  //   'longitude': currentLocation.longitude,
                  //   'latitude': currentLocation.latitude,
                  // },
                  'description': description,
                },
                id: uuid,
              )
                  .then((value) {
                if (value.runtimeType == String) {
                  response = value;
                } else {
                  Map<String, dynamic> document = value;
                  response = document;
                }
              });
            }
          }
        },
      );
    } on SocketException catch (e) {
      response = e.message.toString();
    }
    return response;
  }

  //fetch
  Future<List<PlaceModel>> getAllPlaces() async {
    List<PlaceModel> placesList = [];
    final places = await si.firebaseService.getAllDoc('places');
    if (places.runtimeType == String) {
    } else {
      for (final place
          in places as List<QueryDocumentSnapshot<Map<String, dynamic>>>) {
        placesList.add(PlaceModel.fromJson(place.data()));
      }
    }
    return placesList;
  }
}
