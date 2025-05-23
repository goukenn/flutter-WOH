// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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
  EService? eService;
  EProvider? eProvider;
  List<Option>? options;
  List<Tax>? taxes;
  WOHAddressModel? address;
  Coupon? coupon;
  DateTime? bookingAt;
  DateTime? startAt;
  DateTime? endsAt;
  Payment? payment;

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
      (v) => BookingStatus.fromJson(v),
    );
    user = objectFromJson(json, 'user', (v) => WOHUserModel.fromJson(v));
    eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
    eProvider = objectFromJson(
      json,
      'e_provider',
      (v) => EProvider.fromJson(v),
    );
    address = objectFromJson(
      json,
      'address',
      (v) => WOHAddressModel.fromJson(v),
    );
    coupon = objectFromJson(json, 'coupon', (v) => Coupon.fromJson(v));
    payment = objectFromJson(json, 'payment', (v) => Payment.fromJson(v));
    options = listFromJson(json, 'options', (v) => Option.fromJson(v));
    taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
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
    data['booking_status_id'] = this.status.id;
    data['coupon'] = this.coupon.toJson();
    data['coupon_id'] = this.coupon.id;
    data['taxes'] = this.taxes.map((e) => e.toJson()).toList();
    if (this.options.isNotEmpty) {
      data['options'] = this.options.map((e) => e.id).toList();
    }
    data['user_id'] = this.user.id;
    data['address'] = this.address.toJson();
    data['e_service'] = this.eService.id;
    data['e_provider'] = this.eProvider.toJson();
    data['payment'] = this.payment.toJson();
    data['booking_at'] = bookingAt.toUtc().toString();
    data['start_at'] = startAt.toUtc().toString();
    data['ends_at'] = endsAt.toUtc().toString();
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
    taxes.forEach((element) {
      if (element.type == 'percent') {
        taxValue += (total * element.value / 100);
      } else {
        taxValue += element.value;
      }
    });
    return taxValue;
  }

  double getCouponValue() {
    double total = getSubtotal();
    if (!(coupon.hasData ?? false)) {
      return 0;
    } else {
      if (coupon.discountType == 'percent') {
        return -(total * coupon.discount / 100);
      } else {
        return -coupon.discount;
      }
    }
  }

  double getSubtotal() {
    double total = 0.0;
    if (eService.priceUnit == 'fixed') {
      total = eService.getPrice * (quantity >= 1 ? quantity : 1);
      options.forEach((element) {
        total += element.price * (quantity >= 1 ? quantity : 1);
      });
    } else {
      total = eService.getPrice * duration;
      options.forEach((element) {
        total += element.price;
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
