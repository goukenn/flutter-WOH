// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable


import 'package:hive_flutter/adapters.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; // to add obs

class WOHDomain{
  static var serverPort = "https://willonhair.shintheo.com/api/v1";
  static var serverPort2 = "https://preprod.hubkilo.com/api";
  static var apiKey = "NMMAG3K4IVS0L6VYEPXLJ1Z0RR77AR67";

  static var myBoxStorage = Hive.box("notifications").obs;

  static var deviceToken;

  static var googleUser = false;
  static var googleImage = '';
  static final riKey1 = new GlobalObjectKey<FormState>(1);

  static var authorization = "Basic dGhlb3BoYW5lQHNoaW50aGVvLmNvbTpPbml6dWtAMjI=";
  static var AppName = "Will On Hair";
  static Map<String, String> getTokenHeaders() {
    Map<String, String> headers = new Map();
    headers['Authorization'] = authorization;
    headers['accept'] = 'application/json';
    return headers;
  }
}