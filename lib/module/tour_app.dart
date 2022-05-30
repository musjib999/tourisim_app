import 'package:flutter/material.dart';
import 'package:tour/module/screens/splash_screen.dart';

class TourApp extends StatelessWidget {
  const TourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tourist',
      home: SplashScreen(),
    );
  }
}
