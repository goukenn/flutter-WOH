// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'WOHOptionModel.dart';
import 'parents/WOHModel.dart';

class WOHOptionGroupModel extends WOHModel {
  @override
  String? id;
  String? name;
  bool? allowMultiple;
  List<WOHOptionModel>? options;

  WOHOptionGroupModel({this.id, this.name, this.options});

  WOHOptionGroupModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    allowMultiple = boolFromJson(json, 'allow_multiple');
    options = listFromJson(json, 'options', (v) => WOHOptionModel.fromJson(v));
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["allow_multiple"] = allowMultiple;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHOptionGroupModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          allowMultiple == other.allowMultiple &&
          options == other.options;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ allowMultiple.hashCode ^ options.hashCode;
}