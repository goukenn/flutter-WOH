// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';

import '../../caches/WOHBuildCacheOptions.dart';
import '../models/WOHAddressModel.dart';
import '../models/WOHBookingModel.dart';
import '../models/WOHCategoryModel.dart';
import '../models/WOHEProviderModel.dart';
import '../models/WOHEServiceModel.dart';
import '../models/WOHFaqCategoryModel.dart';
import '../models/WOHNotificationModel.dart';
import '../models/WOHReviewModel.dart';
import '../models/WOHSettingModel.dart';
import '../models/WOHSlideModel.dart';
import '../models/WOHUserModel.dart'; 
import '../services/WOHGlobalService.dart';

class WOHMockApiClientProvider {
  final _globalService = Get.find<WOHGlobalService>();

  String get baseUrl => _globalService.global.value.mockBaseUrl!;

  final Dio httpClient;
  final Options _options = buildCacheOptions() ;//Duration(days: 3), forceRefresh: true);

  WOHMockApiClientProvider({required this.httpClient}) {
    // + | remove cache 
    // httpClient.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
  }

  Future<List<WOHUserModel>> getAllUsers() async {
    var response = await httpClient.get(baseUrl + "users/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHUserModel>((obj) => WOHUserModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHSlideModel>> getHomeSlider() async {
    var response = await httpClient.get(baseUrl + "slides/home.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['results'].map<WOHSlideModel>((obj) => WOHSlideModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<WOHUserModel> getLogin() async {
    var response = await httpClient.get(baseUrl + "users/user.json", options: _options);
    if (response.statusCode == 200) {
      return WOHUserModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHAddressModel>> getAddresses() async {
    var response = await httpClient.get(baseUrl + "users/addresses.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHAddressModel>((obj) => WOHAddressModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getRecommendedEServices() async {
    var response = await httpClient.get(baseUrl + "services/recommended.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getAllEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getAllEServicesWithPagination(int? page) async {
    var response = await httpClient.get(baseUrl + "services/all_page_$page.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getFavoritesEServices() async {
    var response = await httpClient.get(baseUrl + "services/favorites.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<WOHEServiceModel> getEService(String? id) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHEServiceModel> _list = response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
      return _list.firstWhere((element) => element.id == id, orElse: () => new WOHEServiceModel());
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<WOHEProviderModel> getEProvider(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "providers/eprovider.json", options: _options);
    if (response.statusCode == 200) {
      return WOHEProviderModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHReviewModel>> getEProviderReviews(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "providers/reviews.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHReviewModel>((obj) => WOHReviewModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderFeaturedEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/featured.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  // getEProviderMostRatedEServices
  Future<List<WOHEServiceModel>> getEProviderPopularEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/popular.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderAvailableEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHEServiceModel> _services = response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
      _services = _services.where((_service) {
        return _service.eProvider!.available!;
      }).toList();
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderMostRatedEServices(String eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHEServiceModel> _services = response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
      _services.sort((s1, s2) {
        return s2.rate!.compareTo(s1.rate!);
      });
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderEServicesWithPagination(String? eProviderId, int? page) async {
    var response = await httpClient.get(baseUrl + "services/all_page_$page.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHReviewModel>> getEServiceReviews(String? eServiceId) async {
    var response = await httpClient.get(baseUrl + "services/reviews.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHReviewModel>((obj) => WOHReviewModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getFeaturedEServices() async {
    var response = await httpClient.get(baseUrl + "services/featured.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getPopularEServices() async {
    var response = await httpClient.get(baseUrl + "services/popular.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getMostRatedEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHEServiceModel> _services = response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
      _services.sort((s1, s2) {
        return s2.rate!.compareTo(s1.rate!);
      });
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHEServiceModel>> getAvailableEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHEServiceModel> _services = response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
      _services = _services.where((_service) {
        return _service.eProvider!.available!;
      }).toList();
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHCategoryModel>> getAllCategories() async {
    var response = await httpClient.get(baseUrl + "categories/all2.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['results'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHCategoryModel>> getAllWithSubCategories() async {
    var response = await httpClient.get(baseUrl + "categories/subcategories.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['results'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHCategoryModel>> getFeaturedCategories() async {
    var response = await httpClient.get(baseUrl + "categories/featured.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHBookingModel>> getBookings(int? page) async {
    var response = await httpClient.get(baseUrl + "tasks/all_page_$page.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHBookingModel>((obj) => WOHBookingModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<WOHBookingModel> getBooking(String? bookingId) async {
    var response = await httpClient.get(baseUrl + "tasks/all.json", options: _options);
    if (response.statusCode == 200) {
      List<WOHBookingModel> _bookings = response.data['data'].map<WOHBookingModel>((obj) => WOHBookingModel.fromJson(obj)).toList();
      return _bookings.firstWhere((element) => element.id == bookingId, orElse: () => new WOHBookingModel());
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHNotificationModel>> getNotifications() async {
    var response = await httpClient.get(baseUrl + "notifications/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHNotificationModel>((obj) => WOHNotificationModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<WOHFaqCategoryModel>> getCategoriesWithFaqs() async {
    var response = await httpClient.get(baseUrl + "help/faqs.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<WOHFaqCategoryModel>((obj) => WOHFaqCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<WOHSettingModel> getSettings() async {
    var response = await httpClient.get(baseUrl + "settings/all.json", options: _options);
    if (response.statusCode == 200) {
      return WOHSettingModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }
}