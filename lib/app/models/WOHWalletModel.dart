// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:math';

import '../../common/WOHUuid.dart';
import 'parents/WOHModel.dart';

class WOHWalletModel extends WOHModel {
   @override
  String? id;
  String? name;
  double? balance;

  WOHWalletModel({this.id, this.name, this.balance});

  WOHWalletModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = stringFromJson(json, 'name');
    balance = doubleFromJson(json, 'balance');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
      data['name'] = this.name;
      data['balance'] = this.balance;
      return data;
  }

  String? getName() {
    var n = name ?? "";
    return n.substring(n.length - min(n.length, 16), n.length);
  }

  String getId() {
    if (WOHUuid.isUuid(id!)) {
      var x = ''+id!;
      return x.substring(0, 3) + ' . . . ' + x.substring(x.length - 5, x.length);
    } else {
      return id ?? '';
    }
  }
}