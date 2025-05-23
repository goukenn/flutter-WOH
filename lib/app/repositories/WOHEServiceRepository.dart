// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../models/WOHEServiceModel.dart';
import '../models/WOHFavoriteModel.dart';
import '../models/WOHOptionGroupModel.dart';
import '../models/WOHReviewModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHEServiceRepository {
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHEServiceRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHEServiceModel>> getAllWithPagination(String categoryId, {int? page}) {
    return _laravelApiClient.getAllEServicesWithPagination(categoryId, page);
  }

  Future<List<WOHEServiceModel>> search(String keywords, List<String> categories, {int? page = 1}) {
    return _laravelApiClient.searchEServices(keywords, categories, page);
  }

  Future<List<WOHFavoriteModel>> getFavorites() {
    return _laravelApiClient.getFavoritesEServices();
  }

  Future<WOHFavoriteModel> addFavorite(WOHFavoriteModel favorite) {
    return _laravelApiClient.addFavoriteEService(favorite);
  }

  Future<bool> removeFavorite(WOHFavoriteModel favorite) {
    return _laravelApiClient.removeFavoriteEService(favorite);
  }

  Future<List<WOHEServiceModel>> getRecommended() {
    return _laravelApiClient.getRecommendedEServices();
  }

  Future<List<WOHEServiceModel>> getFeatured(String categoryId, {int? page}) {
    return _laravelApiClient.getFeaturedEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getPopular(String categoryId, {int? page}) {
    return _laravelApiClient.getPopularEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getMostRated(String categoryId, {int? page}) {
    return _laravelApiClient.getMostRatedEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getAvailable(String categoryId, {int? page}) {
    return _laravelApiClient.getAvailableEServices(categoryId, page);
  }

  Future<WOHEServiceModel> get(String id) {
    return _laravelApiClient.getEService(id);
  }

  Future<List<WOHReviewModel>> getReviews(String eServiceId) {
    return _laravelApiClient.getEServiceReviews(eServiceId);
  }

  Future<List<WOHOptionGroupModel>> getOptionGroups(String eServiceId) {
    return _laravelApiClient.getEServiceOptionGroups(eServiceId);
  }
}