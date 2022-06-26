import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/module/screens/menus/single_place.dart';

import '../../../core/injector.dart';
import '../../../data/model/place_model.dart';
import '../../../shared/global/global_var.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Explore'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: FutureBuilder<List<PlaceModel>>(
              future: si.placesService.getAllPlaces(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                List<PlaceModel>? places = snapshot.data;
                return places!.isEmpty
                    ? const Center(
                        child: Text(
                          'No Place Added Yet!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => si.routerService.nextRoute(
                              context,
                              SinglePlace(place: places[index]),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, bottom: 15.0),
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
                                    child:
                                        si.utilityService.getCachedNetworkImage(
                                      url: places[index].image,
                                      height: 230,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    places[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Ionicons.location_outline,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                          Text(
                                            places[index].location,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (!favouritePlaces.places
                                              .contains(places[index])) {
                                            favouritePlaces.addFavouritePlace(
                                                places[index]);
                                            si.utilityService.showSnackBar(
                                              context: context,
                                              body: 'Spot Added to Favourite',
                                            );
                                          } else {
                                            favouritePlaces
                                                .removeFavouritePlace(
                                                    places[index]);
                                            si.utilityService.showSnackBar(
                                              context: context,
                                              body: 'Spot Removed to Favourite',
                                            );
                                          }
                                        },
                                        icon: favouritePlaces.places
                                                .contains(places[index])
                                            ? const Icon(
                                                Ionicons.heart,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Ionicons.heart_outline),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
