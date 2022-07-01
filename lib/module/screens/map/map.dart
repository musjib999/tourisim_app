import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour/data/model/location_model.dart';
import 'package:tour/shared/theme/colors.dart';

import '../../../core/injector.dart';
import '../../../shared/widgets/cards/faded_background_container.dart';

class PlaceMap extends StatefulWidget {
  final LocationModel position;
  const PlaceMap({Key? key, required this.position}) : super(key: key);

  @override
  State<PlaceMap> createState() => _PlaceMapState();
}

class _PlaceMapState extends State<PlaceMap> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.position.latitude, widget.position.longitude),
              zoom: 14.4746,
            ),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: <Marker>{
              Marker(
                markerId: const MarkerId('marker_1'),
                position: LatLng(
                  widget.position.latitude,
                  widget.position.longitude,
                ),
              ),
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => si.routerService.popRoute(context),
                  child: FadedBackgroundContainer(
                    color: AppColors.primaryColor,
                    icon: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : Icons.arrow_back_ios),
                    shape: BoxShape.circle,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
