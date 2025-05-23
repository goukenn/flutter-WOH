import 'app/models/WOHTravelModel.dart';

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
    "departure_date": "${departureDate!.year.toString().padLeft(4, '0')}-${departureDate!.month.toString().padLeft(2, '0')}-${departureDate!.day.toString().padLeft(2, '0')}",
    "arrival_date": "${arrivalDate!.year.toString().padLeft(4, '0')}-${arrivalDate!.month.toString().padLeft(2, '0')}-${arrivalDate!.day.toString().padLeft(2, '0')}",
    "kilo_qty": kiloQty,
    "price_per_kilo": pricePerKilo,
    "type_of_luggage_accepted": typeOfLuggageAccepted,
    "user": user!.toJson(),
  };
}





