import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/data/model/category_model.dart';
import 'package:tour/data/model/place_model.dart';
import 'package:tour/module/screens/menus/add_place.dart';
import 'package:tour/module/screens/menus/category/all_category.dart';
import 'package:tour/module/screens/menus/place/all_place_by_category.dart';
import 'package:tour/module/screens/menus/single_place.dart';
import 'package:tour/shared/theme/colors.dart';

import '../../../core/injector.dart';
import '../../../shared/global/global_var.dart';
import '../../../shared/widgets/cards/app_bar_leading_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> filters = ['All', 'Recommended', 'Popular', 'Ratings', 'States'];
  int selectedItem = 0;
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
        leading: const AppBarLeadingButton(icon: Ionicons.menu),
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
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/empty.svg',
                              width: 120,
                            ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'No Place Added Yet!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 225.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: places.length > 4 ? 4 : places.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => si.routerService.nextRoute(
                                  context,
                                  SinglePlace(place: places[index]),
                                ),
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
                                          url: places[index].image,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => si.routerService.nextRoute(
                      context,
                      AllCategory(categories: categories),
                    ),
                    child: const Text('More...'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length > 5 ? 5 : categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => si.routerService.nextRoute(
                        context,
                        AllPlacesByCategory(
                            category: categories[index].category),
                      ),
                      child: Column(
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          si.utilityService.showBottomSheetDialog(
            context: context,
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String imagePath = await si.utilityService
                          .snapPicture(ImageSource.camera);
                      Navigator.pop(context);
                      si.routerService.nextRoute(
                        context,
                        AddPlace(imagePath: imagePath),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Ionicons.camera_outline,
                          size: 80,
                        ),
                        SizedBox(height: 8.0),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: VerticalDivider(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String imagePath = await si.utilityService
                          .snapPicture(ImageSource.gallery);
                      Navigator.pop(context);
                      si.routerService.nextRoute(
                        context,
                        AddPlace(imagePath: imagePath),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.image_outlined,
                          size: 80,
                        ),
                        SizedBox(height: 8.0),
                        Text('Gallary'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
