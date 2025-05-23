// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'app/models/WOHUserModel.dart';

class WOHResponse {
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

  WOHResponse({
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

  factory WOHResponse.fromJson(Map<String, dynamic> json) => WOHResponse(
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
    "departure_date": "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
    "arrival_date": "${arrivalDate!.year.toString().padLeft(4, '0')}-${arrivalDate!.month.toString().padLeft(2, '0')}-${arrivalDate!.day.toString().padLeft(2, '0')}",
    "kilo_qty": kiloQty,
    "price_per_kilo": pricePerKilo,
    "type_of_luggage_accepted": typeOfLuggageAccepted,
    "user": user!.toJson(),
  };
}