import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/textfield.dart';
import 'search.dart';

class MapHome extends StatefulWidget {
  const MapHome({super.key});

  static const String route = '/map_home';

  @override
  State<MapHome> createState() => MapHomeState();
}

class MapHomeState extends State<MapHome> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      showCustomDialog(
        context,
        title: 'Enable Location',
        description: 'Enable location services to proceed',
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        if (!mounted) {
          return null;
        }
        showCustomDialog(
          context,
          title: 'Enable Location',
          description: 'Location permissions have been denied, enable locations in settings',
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      if (!mounted) {
        return null;
      }

      showCustomDialog(
        context,
        title: 'Enable Location',
        description: 'Location permissions have been denied, enable locations in settings',
      );

      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  CameraPosition? currentPos;

  @override
  void initState() {
    super.initState();

    _determinePosition().then((loc) {
      if (loc != null) {
        setState(() {
          currentPos = CameraPosition(
            target: LatLng(
              loc.latitude,
              loc.latitude,
            ),
            zoom: 16,
          );
        });
      }
    });
  }

  Future<void> animateToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        currentPos!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (currentPos != null)
          ? Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: currentPos!,
                  onMapCreated: (GoogleMapController controller) {
                    console('GoogleMapController created');
                    _controller.complete(controller);
                  },

                  myLocationEnabled: true,
                  // myLocationButtonEnabled: false,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().statusBarHeight + 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: CustomTextField(
                        hintText: 'Search Location',
                        prefixIcon: 'assets/svg/search.svg',
                        hintStyle: medium.copyWith(
                          fontSize: 16.sp,
                          letterSpacing: -0.41,
                        ),
                        onTap: () {
                          console('Search');
                          // TODO: Make controller and use Providers
                          Navigator.pushNamed(context, SearchMap.route, arguments: {
                            'currentPos': currentPos?.target,
                          });
                        },
                        readOnly: true,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: CupertinoActivityIndicator(radius: 15.w),
            ),
      floatingActionButton: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          FloatingActionButton(
            heroTag: 'currLoc',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            onPressed: () {
              // zoom to current location
              animateToCurrentLocation();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_searching,
                color: AppColors.primaryColor,
                size: 30,
              ),
            ),
          ),
          const Spacer(),
          // FloatingActionButton.extended(
          //   onPressed: () {},
          //   label: const Text(
          //     'Search',
          //   ),
          //   icon: const Icon(
          //     Icons.search,
          //   ),
          // ),
        ],
      ),
    );
  }
}
