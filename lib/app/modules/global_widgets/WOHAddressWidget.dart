// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, use_super_parameters
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../routes/WOHRoutes.dart';
import '../../services/WOHSettingsService.dart';
import 'WOHAddressWidgetState.dart' show WOHAddressWidgetState;

class WOHAddressWidget extends StatefulWidget {
  const WOHAddressWidget({
    Key? key
  });

  @override
  State<WOHAddressWidget> createState() => WOHAddressWidgetState();

}

