// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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