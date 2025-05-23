// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../models/WOHEServiceModel.dart';
import '../models/WOHFavoriteModel.dart';
import '../models/WOHOptionGroupModel.dart';
import '../models/WOHReviewModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHEServiceRepository {
  WOHLaravelApiClientProvider _laravelApiClient;

  WOHEServiceRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHEServiceModel>> getAllWithPagination(String? categoryId, {int? page}) {
    return _laravelApiClient.getAllEServicesWithPagination(categoryId, page);
  }

  Future<List<WOHEServiceModel>> search(String? keywords, List<String> categories, {int? page = 1}) {
    return _laravelApiClient.searchEServices(keywords, categories, page);
  }

  Future<List<Favorite>> getFavorites() {
    return _laravelApiClient.getFavoritesEServices();
  }

  Future<Favorite> addFavorite(Favorite favorite) {
    return _laravelApiClient.addFavoriteEService(favorite);
  }

  Future<bool> removeFavorite(Favorite favorite) {
    return _laravelApiClient.removeFavoriteEService(favorite);
  }

  Future<List<WOHEServiceModel>> getRecommended() {
    return _laravelApiClient.getRecommendedEServices();
  }

  Future<List<WOHEServiceModel>> getFeatured(String? categoryId, {int? page}) {
    return _laravelApiClient.getFeaturedEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getPopular(String? categoryId, {int? page}) {
    return _laravelApiClient.getPopularEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getMostRated(String? categoryId, {int? page}) {
    return _laravelApiClient.getMostRatedEServices(categoryId, page);
  }

  Future<List<WOHEServiceModel>> getAvailable(String? categoryId, {int? page}) {
    return _laravelApiClient.getAvailableEServices(categoryId, page);
  }

  Future<WOHEServiceModel> get(String? id) {
    return _laravelApiClient.getEService(id);
  }

  Future<List<WOHReviewModel>> getReviews(String? eServiceId) {
    return _laravelApiClient.getEServiceReviews(eServiceId);
  }

  Future<List<OptionGroup>> getOptionGroups(String? eServiceId) {
    return _laravelApiClient.getEServiceOptionGroups(eServiceId);
  }
}