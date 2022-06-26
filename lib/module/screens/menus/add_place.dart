import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/core/injector.dart';
import 'package:tour/shared/global/global_var.dart';
import 'package:tour/shared/widgets/buttons/primary_button.dart';
import 'package:uuid/uuid.dart';

class AddPlace extends StatefulWidget {
  final String imagePath;
  const AddPlace({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Spot'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 240,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  label: Text(cityAndCountry),
                  enabled: false,
                  prefixIcon: const Icon(Icons.location_city_outlined),
                ),
              ),
              // const SizedBox(height: 25),
              // const Text(
              //   'Position',
              //   style: TextStyle(
              //     fontSize: 17,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 160,
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           label: Text(currentLocation.longitude.toString()),
              //           enabled: false,
              //           prefixIcon: const Icon(Icons.location_on_outlined),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 160,
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           label: Text(currentLocation.latitude.toString()),
              //           enabled: false,
              //           prefixIcon: const Icon(Icons.location_on_outlined),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 15),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.text_format),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 8,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              Center(
                child: PrimaryButton(
                  onTap: (startLoading, stopLoading, btnState) async {
                    String id = const Uuid().v4().split('-').join();
                    startLoading();
                    dynamic imageUploaded = await si.placesService.addPlace(
                      uuid: id,
                      imagePath: widget.imagePath,
                      name: name.text,
                      description: description.text,
                      location: cityAndCountry,
                    );
                    if (imageUploaded.runtimeType == String) {
                      stopLoading();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Ionicons.warning_outline,
                                color: Colors.red,
                              ),
                              Text('Cannot Add Spot!!!'),
                            ],
                          ),
                        ),
                      );
                    } else {
                      stopLoading();
                      name.clear();
                      description.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text('Spot Added Successfully!!!'),
                            ],
                          ),
                        ),
                      );
                      si.routerService.popRoute(context);
                    }
                  },
                  buttonTitle: 'Add',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
