// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable

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