// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/WOHUi.dart';

// import '../../services/translation_service.dart';
import '../../services/WOHTranslationService.dart';
import '../WOHMediaModel.dart'; 

abstract class WOHModel {
  String? id;

  bool? get hasData => id != null;

  void fromJson(Map<String, dynamic> json) {
    id = stringFromJson(json, 'id');
  }

  // @override
  // bool operator == (dynamic other) {
  //   return other.id == id;
  // }

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return toJson().toString();
  }

  Color colorFromJson(
    Map<String, dynamic>? json,
    String? attribute, {
    String? defaultHexColor = "#000000",
  }) {
    try {
      return WOHUi.parseColor(
        json != null
            ? json[attribute] != null
                  ? json[attribute].toString()
                  : defaultHexColor!
            : defaultHexColor!
      );
    } catch (e) {
      throw Exception('Error while parsing ${attribute!}[$e]');
    }
  }

  String? stringFromJson(
    Map<String, dynamic>? json,
    String? attribute, {
    String? defaultValue = '',
  }) {
    try {
      return json != null
          ? json[attribute] != null
                ? json[attribute].toString()
                : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  String? transStringFromJson(
    Map<String, dynamic> json,
    String? attribute, {
    String? defaultValue = '',
    String? defaultLocale,
  }) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is Map<String, dynamic>) {
          var json2 = json[attribute][defaultLocale ?? Get.locale?.languageCode];
          if (json2 == null) {
            var languageCode2 = Get.find<WOHTranslationService>()
                .getLocale()
                .languageCode;
            if (json[attribute][languageCode2] != null &&
                json[attribute][languageCode2] != 'null') {
              return json[attribute][languageCode2].toString();
            } else {
              return defaultValue;
            }
          } else {
            if (json2 != null && json2 != 'null') {
              return json2;
            } else {
              return defaultValue;
            }
          }
        } else {
          return json[attribute].toString();
        }
      } else {
        return defaultValue;
      }
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  DateTime? dateFromJson(
    Map<String, dynamic>? json,
    String? attribute, {
    DateTime? defaultValue,
  }) {
    try {
      return json != null
          ? json[attribute] != null
                ? DateTime.parse(json[attribute]).toLocal()
                : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  dynamic mapFromJson(
    Map<String, dynamic>? json,
    String? attribute, {
    required Map<dynamic, dynamic> defaultValue,
  }) {
    try {
      return json != null
          ? json[attribute] != null
                ? jsonDecode(json[attribute])
                : defaultValue
          : defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  int? intFromJson(
    Map<String, dynamic> json,
    String? attribute, {
    int? defaultValue = 0,
  }) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is int) {
          return json[attribute];
        }
        return int.parse(json[attribute]);
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing ${attribute!}[$e]');
    }
  }

  double? doubleFromJson(
    Map<String, dynamic> json,
    String? attribute, {
    int? decimal = 2,
    double? defaultValue = 0.0,
  }) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is double) {
          return double.parse(json[attribute].toStringAsFixed(decimal));
        }
        if (json[attribute] is int) {
          return double.parse(
            json[attribute].toDouble().toStringAsFixed(decimal),
          );
        }
        return double.parse(
          double.tryParse(json[attribute])!.toStringAsFixed(decimal ?? 1),
        );
      }
      return defaultValue;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  

  WOHMediaModel? mediaFromJson(Map<String, dynamic> json, String attribute) {
    try { 
      WOHMediaModel media = new WOHMediaModel();
      if (json['media'] != null && (json['media'] as List).isNotEmpty) {
        media = WOHMediaModel.fromJson(json['media'][0]);
      }
      return media;
    } catch (e) {
      throw Exception(
        'Error while parsing ' + attribute + '[' + e.toString() + ']',
      );
    }
  }

  bool boolFromJson(
    Map<String, dynamic> json,
    String attribute, {
    bool defaultValue = false,
  }) {
    try {
      if (json[attribute] != null) {
        if (json[attribute] is bool) {
          return json[attribute];
        } else if ((json[attribute] is String) &&
            !['0', '', 'false'].contains(json[attribute])) {
          return true;
        } else if ((json[attribute] is int) &&
            ![0, -1].contains(json[attribute])) {
          return true;
        }
        return false;
      }
      return defaultValue;
    } catch (e) {
      throw Exception(
        'Error while parsing ' + attribute + '[' + e.toString() + ']',
      );
    }
  }

  List<T> listFromJsonArray<T>(
    Map<String, dynamic> json,
    List<String> attribute,
    T Function(Map<String, dynamic>) callback,
  ) {
    String _attribute = attribute.firstWhere(
      (element) => (json[element] != null)      
    );
    return listFromJson(json, _attribute, callback);
  }

  List<T> listFromJson<T>(
    Map<String, dynamic> json,
    String? attribute,
    T Function(Map<String, dynamic>) callback,
  ) {
    try {
      List<T> _list = <T>[];
      if (json[attribute] != null &&
          json[attribute] is List &&
          json[attribute].length > 0) {
        json[attribute].forEach((v) {
          if (v is Map<String, dynamic>) {
            _list.add(callback(v));
          }
        });
      }
      return _list;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  T objectFromJson<T>(
    Map<String, dynamic> json,
    String? attribute,
    T Function(Map<String, dynamic>) callback, {
    T? defaultValue = null,
  }) {
    try {
      if (json[attribute] != null && json[attribute] is Map<String, dynamic>) {
        return callback(json[attribute]);
      }
      return defaultValue!;
    } catch (e) {
      throw Exception('Error while parsing $attribute[$e]');
    }
  }

  List<WOHMediaModel> mediaListFromJson(Map<String, dynamic>? json, String attribute) {
    try {
      List<WOHMediaModel> medias = [new WOHMediaModel()];
      if (json != null &&
          json['media'] != null &&
          (json['media'] as List).length > 0) {
        medias = List.from(
          json['media'],
        ).map((element) => WOHMediaModel.fromJson(element)).toSet().toList();
      }
      return medias;
    } catch (e) {
      throw Exception(
        'Error while parsing ' + attribute + '[' + e.toString() + ']',
      );
    }
  }
}