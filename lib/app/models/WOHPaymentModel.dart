// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'parents/WOHModel.dart';
import 'WOHPaymentMethodModel.dart';
import 'WOHPaymentStatusModel.dart';

class WOHPaymentModel extends WOHModel {
  @override
  String? id;
  String? description;
  double? amount;
  WOHPaymentMethodModel? paymentMethod;
  WOHPaymentStatusModel? paymentStatus;

  WOHPaymentModel({this.id, this.description, this.amount, this.paymentMethod, this.paymentStatus});

  WOHPaymentModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    amount = doubleFromJson(json, 'amount');
    paymentMethod = objectFromJson(json, 'payment_method', (v) => WOHPaymentMethodModel.fromJson(v));
    paymentStatus = objectFromJson(json, 'payment_status', (v) => WOHPaymentStatusModel.fromJson(v));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['payment_method_id'] = this.paymentMethod!.id;
      data['payment_status_id'] = this.paymentStatus!.id;
      return data;
  }
}