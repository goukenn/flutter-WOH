// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:math';

import 'package:get/get.dart';

import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';
import 'WOHWalletModel.dart';

class WOHPaymentMethodModel extends WOHModel {
  @override
  String? id;
  String? name;
  String? description;
  WOHMediaModel? logo;
  String? route;
  int? order;
  bool? isDefault;
  WOHWalletModel? wallet;

  WOHPaymentMethodModel({this.id, this.name, this.description, this.route, this.logo, this.wallet, this.isDefault = false});

  WOHPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    route = stringFromJson(json, 'route');
    logo = mediaFromJson(json, 'logo');
    order = intFromJson(json, 'order');
    isDefault = boolFromJson(json, 'default');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  String? getName() {
    var v_name = name ?? "Not Paid".tr;
    return v_name.substring(v_name.length - min(v_name.length, 10), v_name.length);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHPaymentMethodModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          route == other.route &&
          order == other.order &&
          wallet == other.wallet;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode ^ route.hashCode ^ order.hashCode ^ wallet.hashCode;
}