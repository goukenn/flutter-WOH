// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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