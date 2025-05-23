// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'WOHEServiceModel.dart';
import 'WOHOptionModel.dart';
import 'parents/WOHModel.dart';

class WOHFavoriteModel extends WOHModel {
  @override 
  String? id;
  WOHEServiceModel? eService;
  List<WOHOptionModel>? options;
  String? userId;

  WOHFavoriteModel({this.id, this.eService, this.options, this.userId});

  WOHFavoriteModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    eService = objectFromJson(json, 'e_service', (v) => WOHEServiceModel.fromJson(v));
    options = listFromJson(json, 'options', (v) => WOHOptionModel.fromJson(v));
    userId = stringFromJson(json, 'user_id');
  }
@override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["e_service_id"] = eService!.id;
    map["user_id"] = userId;
    map["options"] = options!.map((element) => element.id).toList();
      return map;
  }
}