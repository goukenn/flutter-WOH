// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';

class Option extends WOHModel {
  String? id;
  String? optionGroupId;
  String? eServiceId;
  String? name;
  double? price;
  WOHMediaModel? image;
  String? description;
  var checked = false.obs;

  Option({this.id, this.optionGroupId, this.eServiceId, this.name, this.price, this.image, this.description, this.checked});

  Option.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    optionGroupId = stringFromJson(json, 'option_group_id', defaultValue: '0');
    eServiceId = stringFromJson(json, 'e_service_id', defaultValue: '0');
    name = transStringFromJson(json, 'name');
    price = doubleFromJson(json, 'price');
    description = transStringFromJson(json, 'description');
    image = mediaFromJson(json, 'image');
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["description"] = description;
    if (checked != null) map["checked"] = checked.value;
    map["option_group_id"] = optionGroupId;
    map["e_service_id"] = eServiceId;
    map['image'] = this.image.toJson();
      return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Option &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          optionGroupId == other.optionGroupId &&
          eServiceId == other.eServiceId &&
          name == other.name &&
          price == other.price &&
          image == other.image &&
          description == other.description &&
          checked == other.checked;

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ optionGroupId.hashCode ^ eServiceId.hashCode ^ name.hashCode ^ price.hashCode ^ image.hashCode ^ description.hashCode ^ checked.hashCode;
}