// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../models/WOHCategoryModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class CategoryRepository {
  WOHLaravelApiClientProvider _laravelApiClient;

  CategoryRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHCategoryModel>> getAll() {
    return _laravelApiClient.getAllCategories();
  }

  Future<List<WOHCategoryModel>> getAllParents() {
    return _laravelApiClient.getAllParentCategories();
  }

  Future<List<WOHCategoryModel>> getAllWithSubCategories() {
    return _laravelApiClient.getAllWithSubCategories();
  }

  Future<List<WOHCategoryModel>> getSubCategories(String? categoryId) {
    return _laravelApiClient.getSubCategories(categoryId);
  }

  Future<List<WOHCategoryModel>> getFeatured() {
    return _laravelApiClient.getFeaturedCategories();
  }
}