// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHEProviderRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<WOHEProviderModel> get(String eProviderId) {
    return _laravelApiClient.getEProvider(eProviderId);
  }

  Future<List<WOHReviewModel>> getReviews(String eProviderId) {
    return _laravelApiClient.getEProviderReviews(eProviderId);
  }

  Future<List<WOHGalleryModel>> getGalleries(String eProviderId) {
    return _laravelApiClient.getEProviderGalleries(eProviderId);
  }

  Future<List<WOHAwardModel>> getAwards(String eProviderId) {
    return _laravelApiClient.getEProviderAwards(eProviderId);
  }

  Future<List<WOHExperienceModel>> getExperiences(String eProviderId) {
    return _laravelApiClient.getEProviderExperiences(eProviderId);
  }

  Future<List<WOHEServiceModel>> getEServices(String eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderEServices(eProviderId, page);
  }

  Future<List<WOHUserModel>> getEmployees(String eProviderId) {
    return _laravelApiClient.getEProviderEmployees(eProviderId);
  }

  Future<List<WOHEServiceModel>> getPopularEServices(String eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderPopularEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getMostRatedEServices(String eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderMostRatedEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getAvailableEServices(String eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderAvailableEServices(eProviderId, page);
  }

  Future<List<WOHEServiceModel>> getFeaturedEServices(String eProviderId, {int? page}) {
    return _laravelApiClient.getEProviderFeaturedEServices(eProviderId, page);
  }
}