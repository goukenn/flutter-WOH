// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../models/WOHAwardModel.dart';
import '../models/WOHEProviderModel.dart';
import '../models/WOHEServiceModel.dart';
import '../models/WOHExperienceModel.dart';
import '../models/WOHGalleryModel.dart';
import '../models/WOHReviewModel.dart';
import '../models/WOHUserModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHEProviderRepository {
  WOHLaravelApiClientProvider _laravelApiClient;

  WOHEProviderRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<WOHEProviderModel> get(String? eProviderId) {
    return _laravelApiClient.getEProvider(eProviderId);
  }

  Future<List<WOHReviewModel>> getReviews(String? eProviderId) {
    return _laravelApiClient.getEProviderReviews(eProviderId);
  }

  Future<List<Gallery>> getGalleries(String? eProviderId) {
    return _laravelApiClient.getEProviderGalleries(eProviderId);
  }

  Future<List<Award>> getAwards(String? eProviderId) {
    return _laravelApiClient.getEProviderAwards(eProviderId);
  }

  Future<List<Experience>> getExperiences(String? eProviderId) {
    return _laravelApiClient.getEProviderExperiences(eProviderId);
  }

  Future<List<WOHEServiceModel>> getEServices(String? eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderEServices(eProviderId, page);
  }

  Future<List<WOHUserModel>> getEmployees(String? eProviderId) {
    return _laravelApiClient.getEProviderEmployees(eProviderId);
  }

  Future<List<WOHEServiceModel>> getPopularEServices(String? eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderPopularEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getMostRatedEServices(String? eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderMostRatedEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getAvailableEServices(String? eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderAvailableEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getFeaturedEServices(String? eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderFeaturedEServices(eProviderId, page);
  }
}