// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:math';

import 'parents/WOHModel.dart';
import 'WOHUserModel.dart';

enum TransactionActions { CREDIT, DEBIT }

class WOHWalletTransactionModel extends WOHModel {
   @override
  String? id;
  double? amount;
  String? description;
  TransactionActions? action;
  DateTime? dateTime;
  WOHUserModel? user;

  WOHWalletTransactionModel({this.id, this.amount, this.description, this.action, this.user});

  WOHWalletTransactionModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    amount = doubleFromJson(json, 'amount');
    user = objectFromJson(json, 'user', (value) => WOHUserModel.fromJson(value));
    dateTime = dateFromJson(json, 'created_at', defaultValue: null);
    if (json['action'] == 'credit') {
      action = TransactionActions.CREDIT;
    } else if (json['action'] == 'debit') {
      action = TransactionActions.DEBIT;
    }
    }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['action'] = this.action;
    data['user'] = this.user;
    return data;
  }

  String getDescription() {
    var d = description ?? "";
    return d.substring(d.length - min(d.length, 20), d.length);
  }
}