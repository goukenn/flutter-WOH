// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/WOHFaqCategoryModel.dart';
import '../models/WOHFaqModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';
import '../providers/WOHMockApiClientProvider.dart';

class FaqRepository {
  WOHMockApiClientProvider _apiClient;
  WOHLaravelApiClientProvider _laravelApiClient;

  FaqRepository() {
    _laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
    this._apiClient = WOHMockApiClientProvider(httpClient: Dio());
  }

  Future<List<FaqCategory>> getCategoriesWithFaqs() {
    return _apiClient.getCategoriesWithFaqs();
  }

}