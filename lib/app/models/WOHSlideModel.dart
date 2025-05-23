// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';

import 'WOHMediaModel.dart';
import 'WOHEProviderModel.dart';
import 'WOHEServiceModel.dart';
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
  WOHEServiceModel? eService;
  WOHEProviderModel? eProvider;
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
    eService = json['e_service_id'] != null ? WOHEServiceModel(id: json['e_service_id'].toString()) : null;
    eProvider = json['e_provider_id'] != null ? WOHEProviderModel(id: json['e_provider_id'].toString()) : null;
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