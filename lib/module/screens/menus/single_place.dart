import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/core/injector.dart';
import 'package:tour/data/model/place_model.dart';
import 'package:tour/shared/global/global_var.dart';
import 'package:tour/shared/widgets/buttons/primary_button.dart';

import '../../../shared/widgets/cards/faded_background_container.dart';

class SinglePlace extends StatefulWidget {
  final PlaceModel place;
  const SinglePlace({Key? key, required this.place}) : super(key: key);

  @override
  State<SinglePlace> createState() => _SinglePlaceState();
}

class _SinglePlaceState extends State<SinglePlace> {
  @override
  void initState() {
    super.initState();
    print(favouritePlaces.places.contains(widget.place));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: si.utilityService.getCachedNetworkImage(
                    url: widget.place.image,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => si.routerService.popRoute(context),
                        child: FadedBackgroundContainer(
                          icon: Icon(Platform.isAndroid
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios),
                          shape: BoxShape.circle,
                          size: 40,
                        ),
                      ),
                      FadedBackgroundContainer(
                        icon: Icon(
                          Ionicons.heart,
                          color: favouritePlaces.places.contains(widget.place)
                              ? Colors.red
                              : Colors.white,
                        ),
                        shape: BoxShape.circle,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Ionicons.location_outline,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.place.location,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const FadedBackgroundContainer(
                        icon: Icon(
                          Ionicons.heart,
                          color: Colors.red,
                          size: 35,
                        ),
                        shape: BoxShape.rectangle,
                        size: 50,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Likes',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            '1,232',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.place.description == ''
                        ? 'No description added to this spot!'
                        : widget.place.description,
                    style: const TextStyle(color: Colors.grey, wordSpacing: 2),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        onTap: (startLoading, stopLoading, btnState) {},
                        buttonTitle: 'Direction',
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
