import 'package:flutter/material.dart';
import 'package:tour/data/model/location_model.dart';
import 'package:tour/module/screens/menus/explore.dart';
import 'package:tour/module/screens/menus/home.dart';

late LocationModel currentLocation;
String cityAndCountry = '';

List<Widget> tourAppMenu = [
  const HomeScreen(),
  const Explore(),
  Container(),
  Container(),
];
