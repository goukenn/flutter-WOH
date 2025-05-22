// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'dart:math';

import '../../common/WOHUuid.dart';
import 'parents/WOHModel.dart';

class Wallet extends WOHModel {
   @override
  String? id;
  String? name;
  double? balance;

  Wallet({this.id, this.name, this.balance});

  Wallet.fromJson(Map<String, dynamic> json) {
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
    if (WOHUuid.isUuid(id)) {
      var x = ''+id!;
      return x.substring(0, 3) + ' . . . ' + x.substring(x.length - 5, x.length);
    } else {
      return id ?? '';
    }
  }
}