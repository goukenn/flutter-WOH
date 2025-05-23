// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import "parents/WOHModel.dart";
import 'WOHUserModel.dart';

class WOHChatModel extends WOHModel {
  @override
  String? id = UniqueKey().toString();

  // message text
  String? text;

  // time of the message
  int? time;

  // user id who send the message
  String? userId;

  WOHUserModel? user;

  WOHChatModel(this.text, this.time, this.userId, this.user);

  WOHChatModel.fromDocumentSnapshot(DocumentSnapshot jsonMap) {
    try {
      id = jsonMap.id;
      text = jsonMap.get('text') != null ? jsonMap.get('text').toString() : '';
      time = jsonMap.get('time') ?? 0;
      userId = jsonMap.get('user')?.toString();
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is WOHChatModel && runtimeType == other.runtimeType && id == other.id && text == other.text && time == other.time && userId == other.userId;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ text.hashCode ^ time.hashCode ^ userId.hashCode;
}