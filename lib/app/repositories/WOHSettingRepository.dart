// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../models/WOHAddressModel.dart';
import '../models/WOHSettingModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHSettingRepository {
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHSettingRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<WOHSettingModel> get() {
    return _laravelApiClient.getSettings();
  }

  Future<List<dynamic>> getModules() {
    return _laravelApiClient.getModules();
  }

  Future<Map<String, String>> getTranslations(String locale) {
    return _laravelApiClient.getTranslations(locale);
  }

  Future<List<String>> getSupportedLocales() {
    return _laravelApiClient.getSupportedLocales();
  }

  Future<List<WOHAddressModel>> getAddresses() {
    return _laravelApiClient.getAddresses();
  }
}