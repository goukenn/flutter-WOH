// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';

import 'WOHMediaModel.dart';
import 'WOHEProviderModel.dart';
import 'WOHEServiceModel.dart';
import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';

class WOHSlideModel extends WOHModel {
  int? order;
  String? text;
  String? button;
  String? textPosition;
  Color? textColor;
  Color? buttonColor;
  Color? backgroundColor;
  Color? indicatorColor;
  WOHMediaModel? image;
  String? imageFit;
  EService? eService;
  EProvider? eProvider;
  bool? enabled;

  WOHSlideModel({
    this.order,
    this.text,
    this.button,
    this.textPosition,
    this.textColor,
    this.buttonColor,
    this.backgroundColor,
    this.indicatorColor,
    this.image,
    this.imageFit,
    this.eService,
    this.eProvider,
    this.enabled,
  });

  WOHSlideModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    order = intFromJson(json, 'order');
    text = transStringFromJson(json, 'text');
    button = transStringFromJson(json, 'button');
    textPosition = stringFromJson(json, 'text_position');
    textColor = colorFromJson(json, 'text_color');
    buttonColor = colorFromJson(json, 'button_color');
    backgroundColor = colorFromJson(json, 'background_color');
    indicatorColor = colorFromJson(json, 'indicator_color');
    image = mediaFromJson(json, 'image');
    imageFit = stringFromJson(json, 'image_fit');
    eService = json['e_service_id'] != null ? EService(id: json['e_service_id'].toString()) : null;
    eProvider = json['e_provider_id'] != null ? EProvider(id: json['e_provider_id'].toString()) : null;
    enabled = boolFromJson(json, 'enabled');
  }

 @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}