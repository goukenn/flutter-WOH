// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/WOHRoutes.dart';
import '../../services/WOHSettingsService.dart';
import 'WOHAddressWidget.dart';

class WOHAddressWidgetState extends State<WOHAddressWidget> {
  // String? _currentAddress;
  Position? _currentPosition;
  String location = "";  
  String _currentAddress = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.place_outlined),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(WOHRoutes.SETTINGS_ADDRESSES);
                  },
                  child: Obx(() {
                    var s = Get.find<WOHSettingsService>();
                    if (s.address.value.isUnknown()) {
                      return Text("Please choose your address".tr, style: Get.textTheme.bodyLarge!.merge(TextStyle(color: Colors.black)));
                    }
                    return Text(s.address.value.address!, style: Get.textTheme.bodyLarge!.merge(TextStyle(color: Colors.black)));
                  }),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.gps_fixed),
                onPressed: () async {
                  _handleLocationPermission();
                  _getCurrentPosition();
                  //Get.toNamed(WOHRoutes.SETTINGS_ADDRESS_PICKER);
                },
              )
            ],
          ),
          SizedBox(height: 10),
          Text(location, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      location = "LAT: ${_currentPosition!.latitude} and LOG: ${_currentPosition!.longitude}";
      _getAddressFromLatLng();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng() async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        this._currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

        print('${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

}