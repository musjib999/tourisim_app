import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/injector.dart';
import '../../../data/model/place_model.dart';

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
      body: Container(
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
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 8.0, bottom: 15.0),
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
