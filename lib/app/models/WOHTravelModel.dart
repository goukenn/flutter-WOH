// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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