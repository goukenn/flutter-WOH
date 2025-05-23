// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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