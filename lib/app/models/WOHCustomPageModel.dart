// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'parents/WOHModel.dart';

class WOHCustomPageModel extends WOHModel {
  String? id;
  String? title;
  String? content;
  DateTime? updatedAt;

  WOHCustomPageModel({this.id, this.title, this.content, this.updatedAt});

  WOHCustomPageModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    title = transStringFromJson(json, 'title');
    content = transStringFromJson(json, 'content');
    updatedAt = dateFromJson(json, 'updated_at');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHCustomPageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ title.hashCode ^ content.hashCode ^ updatedAt.hashCode;
}