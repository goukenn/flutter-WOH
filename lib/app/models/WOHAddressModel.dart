// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'parents/WOHModel.dart';

class WOHAddressModel extends WOHModel {
  @override
  String? id;
  String? description;
  String? address;
  double? latitude;
  double? longitude;
  bool? isDefault;
  String? userId;

  WOHAddressModel({
    this.id,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.userId,
  });

  WOHAddressModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    address = stringFromJson(json, 'address');
    latitude = doubleFromJson(
      json,
      'latitude',
      defaultValue: null,
      decimal: 10,
    );
    longitude = doubleFromJson(
      json,
      'longitude',
      defaultValue: null,
      decimal: 10,
    );
    isDefault = boolFromJson(json, 'default');
    userId = stringFromJson(json, 'user_id');
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['default'] = this.isDefault;
    data['user_id'] = this.userId;
    return data;
  }

  bool isUnknown() {
    return longitude == null;
  }

  String get getDescription {
    if (hasDescription()) return description!;
    return address!.substring(0, min(address!.length, 10));
  }

  bool hasDescription() {
    if (description!.isNotEmpty) return true;
    return false;
  }

  LatLng getLatLng() {
    if (this.isUnknown()) {
      return LatLng(38.806103, 52.4964453);
    } else {
      return LatLng(this.latitude!, this.longitude!);
    }
  }
}
