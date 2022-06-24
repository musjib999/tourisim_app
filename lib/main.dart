import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour/core/injector.dart';
import 'package:tour/data/source/api.dart';
import 'package:tour/firebase_options.dart';
import 'package:tour/module/screens/splash_screen.dart';
import 'package:tour/shared/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour App',
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondaryColor,
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: AppColors.secondaryColor,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: AppColors.secondaryColor),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imagePath = '';
  String cityAndCountry = '';
  bool isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    super.initState();
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 5),
                Text(cityAndCountry),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              margin: const EdgeInsets.all(15.0),
              padding: imagePath == '' ? const EdgeInsets.all(15.0) : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: imagePath == ''
                  ? const Icon(
                      Icons.image,
                      size: 60,
                      color: AppColors.primaryColor,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            imagePath == ''
                ? Container()
                : Container(
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: cityAndCountry,
                            prefixIcon: const Icon(Icons.location_on),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          maxLines: 8,
                          controller: description,
                          decoration: InputDecoration(
                            hintText: cityAndCountry,
                            prefixIcon: const Icon(Icons.description),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
            MaterialButton(
              child: isLoading == true
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      imagePath == '' ? 'Snap' : 'Upload',
                      style: const TextStyle(color: Colors.white),
                    ),
              color: AppColors.primaryColor,
              onPressed: imagePath == ''
                  ? () async {
                      await si.utilityService
                          .snapPicture(ImageSource.camera)
                          .then((value) {
                        setState(() {
                          imagePath = value;
                        });
                      });
                    }
                  : isLoading == true
                      ? () {}
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          await postRequest(
                            url:
                                'https://187d-102-91-4-73.ngrok.io/tour-dbbd4/us-central1/uploadPlace',
                            formData: FormData.fromMap({
                              'meta': jsonEncode({
                                "name": name.text,
                                "description": description.text,
                                "state": cityAndCountry,
                                "position": {
                                  "longitude": 7.083874,
                                  "latitude": 10.93847
                                },
                              }),
                              'image': await MultipartFile.fromFile(imagePath),
                            }),
                          );

                          setState(() {
                            isLoading = false;
                          });
                          // const uuid = Uuid();

                          // String uid = uuid.v4().split('-').join();
                          // await si.placesService
                          //     .addPlace(
                          //   uuid: uid,
                          //   imagePath: imagePath,
                          //   name: name.text,
                          //   location: cityAndCountry,
                          // )
                          //     .then((value) {
                          //   if (value.runtimeType == String) {
                          //     setState(() {
                          //       isLoading = false;
                          //     });
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(value),
                          //       ),
                          //     );
                          //   } else {
                          //     setState(() {
                          //       isLoading = false;
                          //       imagePath = '';
                          //     });
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content:
                          //             Text('Place has been added successfully'),
                          //       ),
                          //     );
                          //   }
                          // });
                        },
            ),
            MaterialButton(
              child: const Text(
                'Stop',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await si.locationService.getCityAndCountry().then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value),
                  ),
                ),
              );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.location_on),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
