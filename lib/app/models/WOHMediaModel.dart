// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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