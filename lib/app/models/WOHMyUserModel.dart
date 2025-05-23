// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable

import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../services/WOHSettingsService.dart';

class WOHMyUserModel {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? street;
  String? password;
  String? phone;
  String? birthday;
  String? birthplace;
  String? sex;
  bool? isTraveller ;
  String? image;
  var partnerAttachmentIds;
  var deviceTokenIds;


  WOHMyUserModel({
    this.id,
    this.userId,
    this.name,
     this.email,
    this.street,
    this.password,
     this.phone,
     this.birthday,
    this.birthplace,
     this.sex,
     this.isTraveller,
    this.image,
    this.partnerAttachmentIds,
    this.deviceTokenIds,

  });

  factory WOHMyUserModel.fromJson(Map<String, dynamic> json) => WOHMyUserModel(
    id: json["id"],
    userId: json['partner_id'],
    name: json["name"] ,
    email: json["email"],
    street: json["street"],
    password: json["password"],
    phone: json["phone"],
    birthday: json["birthday"],
    birthplace: json["birthplace"],
    sex: json["sex"],
    isTraveller: json["is_traveller"],
    image: json["image_1920"],
  );

  Map<String, dynamic> toJson() => {
    "partner_id": id,
    "name": name,
    "email": email,
    "street": street,
    "password": password,
    "phone": phone,
    "birthday": birthday,
    "birthplace": birthplace,
    "sex": sex,
    "is_traveller": isTraveller,
    "image_1920": isTraveller,

  };

  PhoneNumber getPhoneNumber() {
    var v_phone = this.phone!.replaceAll(' ', '');
    String? dialCode1 = v_phone.substring(1, 2);
    String? dialCode2 = v_phone.substring(1, 3);
    String? dialCode3 = v_phone.substring(1, 4);
    for (int  i = 0; i < countries.length; i++) {
      if (countries[i].dialCode == dialCode1) {
        return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode1, number: v_phone.substring(2));
      } else if (countries[i].dialCode == dialCode2) {
        return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode2, number: v_phone.substring(3));
      } else if (countries[i].dialCode == dialCode3) {
        return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode3, number: v_phone.substring(4));
      }
    }
      return new PhoneNumber(countryISOCode: Get.find<WOHSettingsService>().setting.value.defaultCountryCode!, countryCode: '1', number: '');
  }

}