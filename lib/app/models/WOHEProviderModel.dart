// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'WOHAddressModel.dart';
import 'WOHAvailabilityHourModel.dart';
import 'WOHEProviderTypeModel.dart';
import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';
import 'WOHReviewModel.dart';
import 'WOHTaxModel.dart';
import 'WOHUserModel.dart';

class WOHEProviderModel extends WOHModel {
  @override
  String? id;
  String? name;
  String? description;
  List<WOHMediaModel>? images;
  String? phoneNumber;
  String? mobileNumber;
  WOHEProviderTypeModel? type;
  List<WOHAvailabilityHourModel>? availabilityHours;
  double? availabilityRange;
  bool? available;
  bool? featured;
  List<WOHAddressModel>? addresses;
  List<WOHTaxModel>? taxes;

  List<WOHUserModel>? employees;
  double? rate;
  List<WOHReviewModel>? reviews;
  int? totalReviews;
  bool? verified;
  int? bookingsInProgress;

  WOHEProviderModel(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.phoneNumber,
      this.mobileNumber,
      this.type,
      this.availabilityHours,
      this.availabilityRange,
      this.available,
      this.featured,
      this.addresses,
      this.employees,
      this.rate,
      this.reviews,
      this.totalReviews,
      this.verified,
      this.bookingsInProgress});

  WOHEProviderModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    phoneNumber = stringFromJson(json, 'phone_number');
    mobileNumber = stringFromJson(json, 'mobile_number');
    type = objectFromJson(json, 'e_provider_type', (v) => WOHEProviderTypeModel.fromJson(v));
    availabilityHours = listFromJson(json, 'availability_hours', (v) => WOHAvailabilityHourModel.fromJson(v));
    availabilityRange = doubleFromJson(json, 'availability_range');
    available = boolFromJson(json, 'available');
    featured = boolFromJson(json, 'featured');
    addresses = listFromJson(json, 'addresses', (v) => WOHAddressModel.fromJson(v));
    taxes = listFromJson(json, 'taxes', (v) => WOHTaxModel.fromJson(v));
    employees = listFromJson(json, 'users', (v) => WOHUserModel.fromJson(v));
    rate = doubleFromJson(json, 'rate');
    reviews = listFromJson(json, 'e_provider_reviews', (v) => WOHReviewModel.fromJson(v));
    totalReviews = reviews == null  ? intFromJson(json, 'total_reviews') : reviews!.length;
    verified = boolFromJson(json, 'verified');
    bookingsInProgress = intFromJson(json, 'bookings_in_progress');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['available'] = this.available;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    data['verified'] = this.verified;
    data['bookings_in_progress'] = this.bookingsInProgress;
    return data;
  }

  String get firstImageUrl => this.images?.first.url ?? '';

  String get firstImageThumb => this.images?.first.thumb ?? '';

  String get firstImageIcon => this.images?.first.icon ?? '';

  String get firstAddress {
    if (this.addresses!.isNotEmpty) {
      return this.addresses!.first.address!;
    }
    return '';
  }

  @override
  bool get hasData {
    return name != null;
  }

  Map<String, List<String>> groupedAvailabilityHours() {
    Map<String, List<String>> result = {};
    this.availabilityHours?.forEach((element) {
      var day = element.day!; 
      var g = element.startAt! + ' - ' + element.endAt!;
      if (result.containsKey(day)) {
        result[day]!.add(g);
      } else {
        result[day] = [g];
      }
    });
    return result;
  }

  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    this.availabilityHours?.forEach((element) {
      if (element.day == day) {
        result.add(element.data!);
      }
    });
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHEProviderModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          images == other.images &&
          phoneNumber == other.phoneNumber &&
          mobileNumber == other.mobileNumber &&
          type == other.type &&
          availabilityRange == other.availabilityRange &&
          available == other.available &&
          featured == other.featured &&
          addresses == other.addresses &&
          rate == other.rate &&
          reviews == other.reviews &&
          totalReviews == other.totalReviews &&
          verified == other.verified &&
          bookingsInProgress == other.bookingsInProgress;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      type.hashCode ^
      availabilityRange.hashCode ^
      available.hashCode ^
      featured.hashCode ^
      addresses.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode ^
      bookingsInProgress.hashCode;
}