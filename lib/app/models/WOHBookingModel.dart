// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'WOHAddressModel.dart';
import 'WOHBookingStatusModel.dart';
import 'WOHCouponModel.dart';
import 'WOHEProviderModel.dart';
import 'WOHEServiceModel.dart';
import 'WOHOptionModel.dart';
import 'parents/WOHModel.dart';
import 'WOHPaymentModel.dart';
import 'WOHTaxModel.dart';
import 'WOHUserModel.dart';

class WOHBookingModel extends WOHModel {
  @override
  String? id;
  String? hint;
  bool? cancel;
  double? duration;
  int? quantity;
  WOHBookingStatusModel? status;
  WOHUserModel? user;
  WOHEServiceModel? eService;
  WOHEProviderModel? eProvider;
  List<WOHOptionModel>? options;
  List<WOHTaxModel>? taxes;
  WOHAddressModel? address;
  WOHCouponModel? coupon;
  DateTime? bookingAt;
  DateTime? startAt;
  DateTime? endsAt;
  WOHPaymentModel? payment;

  WOHBookingModel({
    this.id,
    this.hint,
    this.cancel,
    this.duration,
    this.quantity,
    this.status,
    this.user,
    this.eService,
    this.eProvider,
    this.options,
    this.taxes,
    this.address,
    this.coupon,
    this.bookingAt,
    this.startAt,
    this.endsAt,
    this.payment,
  });

  @override
  WOHBookingModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    hint = stringFromJson(json, 'hint');
    cancel = boolFromJson(json, 'cancel');
    duration = doubleFromJson(json, 'duration');
    quantity = intFromJson(json, 'quantity');
    status = objectFromJson(
      json,
      'booking_status',
      (v) => WOHBookingStatusModel.fromJson(v),
    );
    user = objectFromJson(json, 'user', (v) => WOHUserModel.fromJson(v));
    eService = objectFromJson(json, 'e_service', (v) => WOHEServiceModel.fromJson(v));
    eProvider = objectFromJson(
      json,
      'e_provider',
      (v) => WOHEProviderModel.fromJson(v),
    );
    address = objectFromJson(
      json,
      'address',
      (v) => WOHAddressModel.fromJson(v),
    );
    coupon = objectFromJson(json, 'coupon', (v) => WOHCouponModel.fromJson(v));
    payment = objectFromJson(json, 'payment', (v) => WOHPaymentModel.fromJson(v));
    options = listFromJson(json, 'options', (v) => WOHOptionModel.fromJson(v));
    taxes = listFromJson(json, 'taxes', (v) => WOHTaxModel.fromJson(v));
    bookingAt = dateFromJson(json, 'booking_at', defaultValue: null);
    startAt = dateFromJson(json, 'start_at', defaultValue: null);
    endsAt = dateFromJson(json, 'ends_at', defaultValue: null);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['hint'] = this.hint;
    data['duration'] = this.duration;
    data['quantity'] = this.quantity;
    data['cancel'] = this.cancel;
    data['booking_status_id'] = this.status!.id;
    data['coupon'] = this.coupon!.toJson();
    data['coupon_id'] = this.coupon!.id;
    data['taxes'] = this.taxes!.map((e) => e.toJson()).toList();
    if (this.options!.isNotEmpty) {
      data['options'] = this.options!.map((e) => e.id).toList();
    }
    data['user_id'] = this.user!.id;
    data['address'] = this.address!.toJson();
    data['e_service'] = this.eService!.id;
    data['e_provider'] = this.eProvider!.toJson();
    data['payment'] = this.payment!.toJson();
    data['booking_at'] = bookingAt!.toUtc().toString();
    data['start_at'] = startAt!.toUtc().toString();
    data['ends_at'] = endsAt!.toUtc().toString();
    return data;
  }

  double getTotal() {
    double total = getSubtotal();
    total += getTaxesValue();
    total += getCouponValue();
    return total;
  }

  double getTaxesValue() {
    double total = getSubtotal();
    double taxValue = 0.0;
    taxes?.forEach((element) {
      var v = element.value!;
      if (element.type == 'percent') {
        taxValue += (total * v / 100);
      } else {
        taxValue += v;
      }
    });
    return taxValue;
  }

  double getCouponValue() {
    double total = getSubtotal();
    if (!(coupon!.hasData ?? false)) {
      return 0;
    } else {
      if (coupon!.discountType == 'percent') {
        return -(total * coupon!.discount! / 100);
      } else {
        return -coupon!.discount!;
      }
    }
  }

  double getSubtotal() {
    double total = 0.0;
    double v_duration = this.duration!; 
    if (eService!.priceUnit == 'fixed') {
      total = eService!.getPrice! * (quantity! >= 1 ? quantity! : 1);
      options?.forEach((element) {
        total += element.price! * (quantity! >= 1 ? quantity! : 1);
      });
    } else {
      total = eService!.getPrice! * v_duration;
      options?.forEach((element) {
        total += element.price!;
      });
    }
    return total;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHBookingModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hint == other.hint &&
          cancel == other.cancel &&
          duration == other.duration &&
          quantity == other.quantity &&
          status == other.status &&
          user == other.user &&
          eService == other.eService &&
          eProvider == other.eProvider &&
          options == other.options &&
          taxes == other.taxes &&
          address == other.address &&
          coupon == other.coupon &&
          bookingAt == other.bookingAt &&
          startAt == other.startAt &&
          endsAt == other.endsAt &&
          payment == other.payment;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      hint.hashCode ^
      cancel.hashCode ^
      duration.hashCode ^
      quantity.hashCode ^
      status.hashCode ^
      user.hashCode ^
      eService.hashCode ^
      eProvider.hashCode ^
      options.hashCode ^
      taxes.hashCode ^
      address.hashCode ^
      coupon.hashCode ^
      bookingAt.hashCode ^
      startAt.hashCode ^
      endsAt.hashCode ^
      payment.hashCode;
}