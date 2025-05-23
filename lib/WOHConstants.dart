// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

class WOHConstants {
  // + | declare class const
  static const serverPort = "https://willonhair.shintheo.com/api/v1";
  static const apiKey = "NMMAG3K4IVS0L6VYEPXLJ1Z0RR77AR67";
  static const serverPort2 = "https://preprod.hubkilo.com/api";
  //   static var serverPort2 = "https://preprod.hubkilo.com/api";
  static final riKey1 = new GlobalObjectKey<FormState>(1);
  static const authorization =
      "Basic dGhlb3BoYW5lQHNoaW50aGVvLmNvbTpPbml6dWtAMjI=";
  static const AppName = "Will On Hair";
  static var deviceToken;
  static var googleUser = false;
  static var googleImage = '';

  static var myBoxStorage = Hive.box("notifications").obs;

  static Map<String, String> getTokenHeaders() {
    Map<String, String> headers = new Map();
    headers['Authorization'] = authorization;
    headers['accept'] = 'application/json';
    return headers;
  }
}