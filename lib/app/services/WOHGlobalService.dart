// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors

import 'package:get/get.dart';
import '../../common/WOHHelper.dart';
import '../models/WOHGlobalModel.dart'; 

class WOHGlobalService extends GetxService {
  final global = WOHGlobalModel().obs;

  Future<WOHGlobalService> init() async {
    var response = await WOHHelper.getJsonFile('config/global.json');
    global.value = WOHGlobalModel.fromJson(response);
    return this;
  }

  String? get baseUrl => global.value.laravelBaseUrl;
}