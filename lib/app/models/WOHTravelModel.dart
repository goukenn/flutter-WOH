// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
// To parse this JSON data, do
//
//     final travels = travelsFromJson(jsonString);

import 'dart:convert';

WOHTravelModel travelsFromJson(String? str) => WOHTravelModel.fromJson(json.decode(str));

String? travelsToJson(WOHTravelModel data) => json.encode(data.toJson());

class WOHTravelModel {
  Response response;

  WOHTravelModel({
    this.response,
  });

  factory WOHTravelModel.fromJson(Map<String, dynamic> json) => WOHTravelModel(
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
  };
}

class Response {
  int? id;
  String? travelType;
  String? departureTown;
  String? arrivalTown;
  bool? validation;
  DateTime? departureDate;
  DateTime? arrivalDate;
  int? kiloQty;
  int? pricePerKilo;
  String? typeOfLuggageAccepted;
  WOHUserModel? user;

  Response({
    this.id,
    this.travelType,
    this.departureTown,
    this.arrivalTown,
    this.validation,
    this.departureDate,
    this.arrivalDate,
    this.kiloQty,
    this.pricePerKilo,
    this.typeOfLuggageAccepted,
    this.user,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    travelType: json["travel_type"],
    departureTown: json["departure_town"],
    arrivalTown: json["arrival_town"],
    validation: json["validation"],
    departureDate: DateTime.parse(json["departure_date"]),
    arrivalDate: DateTime.parse(json["arrival_date"]),
    kiloQty: json["kilo_qty"],
    pricePerKilo: json["price_per_kilo"],
    typeOfLuggageAccepted: json["type_of_luggage_accepted"],
    user: WOHUserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "travel_type": travelType,
    "departure_town": departureTown,
    "arrival_town": arrivalTown,
    "validation": validation,
    "departure_date": "${departureDate.year.toString().padLeft(4, '0')}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')}",
    "arrival_date": "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
    "kilo_qty": kiloQty,
    "price_per_kilo": pricePerKilo,
    "type_of_luggage_accepted": typeOfLuggageAccepted,
    "user": user.toJson(),
  };
}

class WOHUserModel? {
  int? userId;
  String? userName;
  String? userEmail;

  WOHUserModel({
    this.userId,
    this.userName,
    this.userEmail,
  });

  factory WOHUserModel.fromJson(Map<String, dynamic> json) => WOHUserModel(
    userId: json["user_id"],
    userName: json["user_name"],
    userEmail: json["user_email"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "user_email": userEmail,
  };
}