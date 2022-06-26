import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/shared/global/global_var.dart';

import '../../../core/injector.dart';

class FavouritePlaces extends StatefulWidget {
  const FavouritePlaces({Key? key}) : super(key: key);

  @override
  State<FavouritePlaces> createState() => _FavouritePlacesState();
}

class _FavouritePlacesState extends State<FavouritePlaces> {
  @override
  void initState() {
    super.initState();
    print(favouritePlaces.places);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Spots'),
        elevation: 0,
      ),
      body: Observer(builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView.builder(
            itemCount: favouritePlaces.places.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: si.utilityService.getCachedNetworkImage(
                          url: favouritePlaces.places[index].image,
                          height: 230,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        favouritePlaces.places[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Ionicons.location_outline,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Text(
                                favouritePlaces.places[index].location,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              favouritePlaces.removeFavouritePlace(
                                  favouritePlaces.places[index]);
                              si.utilityService.showSnackBar(
                                context: context,
                                body: 'Spot Removed to Favourite',
                              );
                            },
                            icon: const Icon(
                              Ionicons.heart,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
