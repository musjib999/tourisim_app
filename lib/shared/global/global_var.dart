import 'package:flutter/material.dart';
import 'package:tour/data/model/location_model.dart';
import 'package:tour/module/screens/menus/explore.dart';
import 'package:tour/module/screens/menus/favourites.dart';
import 'package:tour/module/screens/menus/home.dart';

import '../../module/state_management/place_state.dart';

late LocationModel currentLocation;
String cityAndCountry = '';

List<Widget> tourAppMenu = [
  const HomeScreen(),
  const Explore(),
  const FavouritePlaces(),
  Container(),
];

final favouritePlaces = Places();
