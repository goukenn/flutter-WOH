// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';

import 'WOHEServiceModel.dart';
import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';

class WOHCategoryModel extends WOHModel {
  @override
  String? id;
  String? name;
  String? description;
  Color? color;
  WOHMediaModel? image;
  bool? featured;
  List<WOHCategoryModel>? subCategories;
  List<WOHEServiceModel>? eServices;

  WOHCategoryModel({this.id, this.name, this.description, this.color, this.image, this.featured, this.subCategories, this.eServices});

  WOHCategoryModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    color = colorFromJson(json, 'color');
    description = transStringFromJson(json, 'description');
    image = mediaFromJson(json, 'image');
    featured = boolFromJson(json, 'featured');
    eServices = listFromJsonArray(json, ['e_services', 'featured_e_services'], (v) => WOHEServiceModel.fromJson(v));
    subCategories = listFromJson(json, 'sub_categories', (v) => WOHCategoryModel.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    // data['color'] = '#${this.color!.value.toRadixString(16)}';
    data['color'] = '#${this.color!.toARGB32().toRadixString(16)}'; // .value.toRadixString(16)}';
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHCategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          color == other.color &&
          image == other.image &&
          featured == other.featured &&
          subCategories == other.subCategories &&
          eServices == other.eServices;

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode ^ color.hashCode ^ image.hashCode ^ featured.hashCode ^ subCategories.hashCode ^ eServices.hashCode;
}