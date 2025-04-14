import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../models/place_predictions.dart';
import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/textfield.dart';

class SearchMap extends StatefulWidget {
  const SearchMap({super.key});

  static const route = '/search_map';

  @override
  State<SearchMap> createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  /// TODO: Move to env file
  final kGoogleApiKey = 'AIzaSyDNU7YqTdp9oRUPuAve3B0w6XsJh2LFdPs';

  String? sessionToken;
  Timer? _debounce;

  List<PlacePrediction> places = [];

  Future<void> autoCompletePlaces(String search) async {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    sessionToken ??= const Uuid().v4();

    if (args != null && args['currentPos'] != null) {
      final currentPos = args['currentPos'] as LatLng;

      const baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      final request =
          '$baseURL?input=$search&key=$kGoogleApiKey&sessiontoken=$sessionToken&origin=${currentPos.latitude},${currentPos.longitude}';

      if (search.isNotEmpty) {
        console(Uri.parse(request));
        final response = await http.get(Uri.parse(request));

        if (response.statusCode == 200) {
          console(json.decode(response.body));
          setState(() {
            places = PlacePrediction.fromJsonList(json.decode(response.body) as Map<String, dynamic>);
          });
        }
      }
    }
  }

  void onSearchChanged(String search) {
    // Cancel the previous debounce timer if it exists
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      autoCompletePlaces(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().statusBarHeight + 18.h,
              ),
              CustomTextField(
                onSuffixIconTap: () {
                  Navigator.pop(context);
                },
                hintText: 'Search Location',
                prefixIcon: 'assets/svg/search.svg',
                hintStyle: medium.copyWith(
                  fontSize: 16.sp,
                  letterSpacing: -0.41,
                ),
                suffixIcon: 'assets/svg/close.svg',
                onChange: onSearchChanged,
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  padding: EdgeInsets.only(
                    top: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    final place = places[index];

                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 16.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: const BoxDecoration(
                              color: AppColors.lightRedColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/pin.png',
                                width: 25.w,
                                height: 25.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 1.sw - 36.w - 10.w - 10.w - 36.w - 10.w,
                                child: Text(
                                  place.description,
                                  style: medium.copyWith(
                                    fontSize: 16.sp,
                                    letterSpacing: -0.41,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: 1.sw - 36.w - 10.w - 10.w - 36.w - 10.w,
                                child: Text(
                                  '${place.distance} - ${place.secondaryText}',
                                  style: regular.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
