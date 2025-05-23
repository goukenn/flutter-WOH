// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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