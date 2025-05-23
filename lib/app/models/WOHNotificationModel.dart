// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:convert';

class WOHNotificationModel {
  String? myId;
  String? id;
  String? title;
  String? message;
  bool? isSeen;
  bool? disable;
  String? timestamp;

  WOHNotificationModel(
      {this.id, this.title, this.message, this.isSeen, this.timestamp, this.myId, this.disable});

  factory WOHNotificationModel.fromRawJson(String str) =>
      WOHNotificationModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String? toRawJson() => json.encode(toJson());

  factory WOHNotificationModel.fromJson(Map<String, dynamic> json) =>
      WOHNotificationModel(
        id: json['id'] == null ? "00000-0000" : json['id'] as String,
        title: json['title'] == null ? "No title" : json['title'] as String,
        message:
        json['message'] == null ? "No data" : json['message'] as String,
        isSeen: json['isSeen'] == null ? false : json['isSeen'] as bool,
        disable: json['disable'] == null ? false : json['disable'] as bool,
        timestamp: (json['timestamp'] == null
            ? DateTime.now().toString()
            : DateTime.parse(json['timestamp'].toString()).toString()),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'isSeen': isSeen,
      'disable': disable,
      'timestamp': timestamp?.toString(),
    };
  }
}