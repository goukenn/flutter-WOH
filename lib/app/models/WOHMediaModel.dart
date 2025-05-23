// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import '../services/WOHGlobalService.dart';
import './parents/WOHModel.dart';
import 'package:get/get.dart';
 
// woh media model
class WOHMediaModel extends WOHModel {
  @override
  String? id;
  String? name;
  String? url;
  String? thumb;
  String? icon;
  String? size;

  WOHMediaModel({String? id, String? url, String? thumb, String? icon}) {
    this.id = id ?? "";
    this.url = url ?? "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
    this.thumb = thumb ?? "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
    this.icon = icon ?? "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
  }

  WOHMediaModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formatted_size'];
    } catch (e) {
      url = "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
      thumb = "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
      icon = "${Get.find<WOHGlobalService>().baseUrl}images/image_default.png";
      print(e);
    }
  }

@override
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formatted_size"] = size;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHMediaModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url &&
          thumb == other.thumb &&
          icon == other.icon &&
          size == other.size;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ url.hashCode ^ thumb.hashCode ^ icon.hashCode ^ size.hashCode;
}