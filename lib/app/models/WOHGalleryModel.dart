// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';

class Gallery extends WOHModel {
  String? id;
  WOHMediaModel? image;
  String? description;

  Gallery({this.id, this.image, this.description});

  Gallery.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    image = mediaFromJson(json, 'image');
    description = transStringFromJson(json, 'description');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}