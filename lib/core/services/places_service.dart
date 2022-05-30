import 'dart:io';

import '../injector.dart';

class PlacesService {
  Future addPlace({
    required String uuid,
    required String imagePath,
    required String name,
    location,
  }) async {
    dynamic response;
    try {
      await si.firebaseService
          .savedImage(path: '/places/$uuid.png', file: File(imagePath))
          .then(
        (value) async {
          if (value.runtimeType == String) {
            response = value;
          } else if (value.runtimeType == int) {
            int bytes = value;
            if (bytes < 1) {
              response = 'Error while uploading image';
            } else {
              String? imageUrl =
                  await si.firebaseService.getImageUrl('/places/$uuid.png');
              await si.firebaseService
                  .addDoc(
                      collection: 'places',
                      data: {
                        'location': location,
                        'name': name,
                        'image': imageUrl
                      },
                      id: uuid)
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
    print('[addPlace]response $response');
    return response;
  }
}
