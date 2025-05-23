// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
// To parse this JSON data, do
//
//     final travels = travelsFromJson(jsonString);

import 'dart:convert';

import 'package:com_igkdev_new_app/WOHResponse.dart';

WOHTravelModel travelsFromJson(String str) => WOHTravelModel.fromJson(json.decode(str));

String? travelsToJson(WOHTravelModel data) => json.encode(data.toJson());

class WOHTravelModel {
  WOHResponse? response;

  WOHTravelModel({
    this.response,
  });

  factory WOHTravelModel.fromJson(Map<String, dynamic> json) => WOHTravelModel(
    response: WOHResponse.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response!.toJson(),
  };
}


// class WOHUserModel{
//   int? userId;
//   String? userName;
//   String? userEmail;

//   WOHUserModel({
//     this.userId,
//     this.userName,
//     this.userEmail,
//   });

//   factory WOHUserModel.fromJson(Map<String, dynamic> json) => WOHUserModel(
//     userId: json["user_id"],
//     userName: json["user_name"],
//     userEmail: json["user_email"],
//   );

//   Map<String, dynamic> toJson() => {
//     "user_id": userId,
//     "user_name": userName,
//     "user_email": userEmail,
//   };
// }