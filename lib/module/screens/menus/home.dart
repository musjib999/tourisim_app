import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/data/model/category_model.dart';
import 'package:tour/data/model/place_model.dart';
import 'package:tour/shared/theme/colors.dart';

import '../../../core/injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> filters = ['All', 'Recommended', 'Popular', 'Ratings', 'States'];
  int selectedItem = 0;
  String cityAndCountry = 'loading...';
  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();
    si.utilityService.getAllCategories().then((value) => categories = value);
    si.locationService.getCityAndCountry().then((value) {
      setState(() {
        cityAndCountry = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: const Center(
            child: Icon(Ionicons.menu),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 9),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.notifications_outline,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Discover the',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
              const Text(
                'beauty of the world',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Places',
                  prefixIcon: const Icon(Ionicons.search),
                  suffixIcon: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardColor,
                    ),
                    child: const Icon(Ionicons.options_outline),
                  ),
                  fillColor: const Color(0xff322F40),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 40.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: selectedItem == index
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedItem = index;
                          });
                        },
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedItem == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              FutureBuilder<List<PlaceModel>>(
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
                      : SizedBox(
                          height: 210.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8.0),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: si.utilityService
                                            .getCachedNetworkImage(
                                          places[index].image,
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
                          ),
                        );
                },
              ),
              const SizedBox(height: 25),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.only(right: 14.5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardColor,
                          ),
                          child: Image.network(
                            categories[index].image,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categories[index].category,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
