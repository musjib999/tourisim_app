import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tour/data/model/place_model.dart';
import 'package:tour/shared/global/global_var.dart';

import '../injector.dart';

class PlacesService {
  Future addPlace({
    required String uuid,
    required String imagePath,
    required String name,
    required String location,
    required String category,
    required double lat,
    required double long,
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
                  'position': {
                    'longitude': long,
                    'latitude': lat,
                  },
                  'category': category,
                  'description': description,
                  'id': uuid,
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
  Future<List<PlaceModel>> getAllPlaces(
      {String? filter, String? isEqualTo}) async {
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

  Future<List<PlaceModel>> getAllPlacesByCategory(
      {required String category}) async {
    List<PlaceModel> placesList = [];
    final places = await si.firebaseService
        .getAllDocBy('places', filter: 'category', isEqualTo: category);
    if (places.runtimeType == String) {
    } else {
      for (final place
          in places as List<QueryDocumentSnapshot<Map<String, dynamic>>>) {
        placesList.add(PlaceModel.fromJson(place.data()));
      }
    }

    return placesList;
  }

  //add favourite
  Future<dynamic> addToFavourite(
      Map<String, dynamic> data, BuildContext context) async {
    dynamic hasAdded = false;
    try {
      await si.firebaseService.addDoc(collection: 'favourite', data: data);
      hasAdded = true;
    } catch (e) {
      hasAdded = false;
      favouritePlaces.addFavouritePlace(
        PlaceModel.fromJson(data),
      );
    }
    return hasAdded;
  }

  Stream<QuerySnapshot<Object?>> getPlaceLikes() {
    return si.firebaseService.getDocStream('favourite');
  }
}
