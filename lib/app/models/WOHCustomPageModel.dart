// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'parents/WOHModel.dart';

class CustomPage extends WOHModel {
  String? id;
  String? title;
  String? content;
  DateTime? updatedAt;

  CustomPage({this.id, this.title, this.content, this.updatedAt});

  CustomPage.fromJson(Map<String, dynamic> json) {
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
          other is CustomPage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ title.hashCode ^ content.hashCode ^ updatedAt.hashCode;
}