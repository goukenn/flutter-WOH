// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'parents/WOHModel.dart';
import 'WOHPaymentMethodModel.dart';
import 'WOHPaymentStatusModel.dart';

class Payment extends WOHModel {
  String? id;
  String? description;
  double? amount;
  PaymentMethod? paymentMethod;
  PaymentStatus paymentStatus;

  Payment({this.id, this.description, this.amount, this.paymentMethod, this.paymentStatus});

  Payment.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    amount = doubleFromJson(json, 'amount');
    paymentMethod = objectFromJson(json, 'payment_method', (v) => PaymentMethod.fromJson(v));
    paymentStatus = objectFromJson(json, 'payment_status', (v) => PaymentStatus.fromJson(v));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['payment_method_id'] = this.paymentMethod.id;
      data['payment_status_id'] = this.paymentStatus.id;
      return data;
  }
}