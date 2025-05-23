// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'parents/WOHModel.dart';

class WOHCouponModel extends WOHModel {
  String? id;
  String? code;
  double? discount;
  String? discountType;

  WOHCouponModel({this.id, this.code, this.discount, this.discountType});

  WOHCouponModel.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    code = stringFromJson(json, 'code');
    discount = doubleFromJson(json, 'discount');
    discountType = stringFromJson(json, 'discount_type');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    return data;
  }
}