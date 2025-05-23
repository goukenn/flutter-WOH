// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:com_igkdev_new_app/app/models/WOHMediaModel.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/WOHUuid.dart';
import '../services/WOHSettingsService.dart'; 
import 'parents/WOHModel.dart';

class WOHUserModel extends WOHModel {
  String? name;
  String? email;
  String? password;
  WOHMediaModel? avatar;
  String? apiToken;
  String? deviceToken;
  String? phoneNumber;
  bool? verifiedPhone;
  String? verificationId;
  String? address;
  String? bio;

  bool? auth;

  WOHUserModel({
    this.name,
    this.email,
    this.password,
    this.apiToken,
    this.deviceToken,
    this.phoneNumber,
    this.verifiedPhone,
    this.verificationId,
    this.address,
    this.bio,
    this.avatar,
  });

  WOHUserModel.fromJson(Map<String, dynamic> json) {
    name = stringFromJson(json, 'name');
    email = stringFromJson(json, 'email');
    apiToken = stringFromJson(json, 'api_token');
    deviceToken = stringFromJson(json, 'device_token');
    phoneNumber = stringFromJson(json, 'phone_number');
    verifiedPhone = boolFromJson(json, 'phone_verified_at');
    avatar = mediaFromJson(json, 'avatar');
    auth = boolFromJson(json, 'auth');
    try {
      address = json['custom_fields']['address']['view'];
    } catch (e) {
      address = stringFromJson(json, 'address');
    }
    try {
      bio = json['custom_fields']['bio']['view'];
    } catch (e) {
      bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }

@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this.apiToken;
    data["device_token"] = deviceToken;
    data["phone_number"] = phoneNumber;
    if (verifiedPhone!) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    if (WOHUuid.isUuid(avatar!.id!)) {
      data['avatar'] = this.avatar!.id;
    }
    data["media"] = [avatar!.toJson()];
    data['auth'] = this.auth;
    return data;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar!.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  PhoneNumber getPhoneNumber() {
    var c = this.phoneNumber!.replaceAll(' ', '');
    String? dialCode1 = c.substring(1, 2);
    String? dialCode2 = c.substring(1, 3);
    String? dialCode3 = c.substring(1, 4);
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].dialCode == dialCode1) {
        return new PhoneNumber(
          countryISOCode: countries[i].code,
          countryCode: dialCode1,
          number: c.substring(2),
        );
      } else if (countries[i].dialCode == dialCode2) {
        return new PhoneNumber(
          countryISOCode: countries[i].code,
          countryCode: dialCode2,
          number: c.substring(3),
        );
      } else if (countries[i].dialCode == dialCode3) {
        return new PhoneNumber(
          countryISOCode: countries[i].code,
          countryCode: dialCode3,
          number: c.substring(4),
        );
      }
    }
    return new PhoneNumber(
      countryISOCode:
          Get.find<WOHSettingsService>().setting.value.defaultCountryCode!,
      countryCode: '1',
      number: '',
    );
  }

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is WOHUserModel &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      password == other.password &&
      avatar == other.avatar &&
      apiToken == other.apiToken &&
      deviceToken == other.deviceToken &&
      phoneNumber == other.phoneNumber &&
      verifiedPhone == other.verifiedPhone &&
      verificationId == other.verificationId &&
      address == other.address &&
      bio == other.bio &&
      auth == other.auth;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      auth.hashCode;
}