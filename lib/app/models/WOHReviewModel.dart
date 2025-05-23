// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */
import 'WOHEServiceModel.dart';
import 'parents/WOHModel.dart';
import 'WOHUserModel.dart';

class WOHReviewModel extends WOHModel {
  @override
  String? id;
  double? rate;
  String? review;
  DateTime? createdAt;
  WOHUserModel? user;
  WOHEServiceModel? eService;

  WOHReviewModel({this.id, this.rate, this.review, this.createdAt, this.user, this.eService});

  WOHReviewModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    rate = doubleFromJson(json, 'rate');
    review = stringFromJson(json, 'review');
    createdAt = dateFromJson(json, 'created_at', defaultValue: DateTime.now().toLocal());
    user = objectFromJson(json, 'user', (v) => WOHUserModel.fromJson(v));
    eService = objectFromJson(json, 'e_service', (v) => WOHEServiceModel.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['user_id'] = this.user!.id;
      data['e_service_id'] = this.eService!.id;
      return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHReviewModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rate == other.rate &&
          review == other.review &&
          createdAt == other.createdAt &&
          user == other.user &&
          eService == other.eService;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ rate.hashCode ^ review.hashCode ^ createdAt.hashCode ^ user.hashCode ^ eService.hashCode;
}