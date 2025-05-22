// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:dio/dio.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

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
import '../models/slide_model.dart';
import '../services/WOHGlobalService.dart';

class WOHMockApiClientProvider {
  final _globalService = Get.find<WOHGlobalService>();

  String get baseUrl => _globalService.global.value.mockBaseUrl!;

  final Dio httpClient;
  final Options _options = buildCacheOptions() ;//Duration(days: 3), forceRefresh: true);

  WOHMockApiClientProvider({required this.httpClient}) {
    httpClient.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
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

  Future<List<EService>> getRecommendedEServices() async {
    var response = await httpClient.get(baseUrl + "services/recommended.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getAllEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getAllEServicesWithPagination(int? page) async {
    var response = await httpClient.get(baseUrl + "services/all_page_$page.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getFavoritesEServices() async {
    var response = await httpClient.get(baseUrl + "services/favorites.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<EService> getEService(String? id) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<EService> _list = response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
      return _list.firstWhere((element) => element.id == id, orElse: () => new EService());
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<EProvider> getEProvider(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "providers/eprovider.json", options: _options);
    if (response.statusCode == 200) {
      return EProvider.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Review>> getEProviderReviews(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "providers/reviews.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<Review>((obj) => Review.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getEProviderFeaturedEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/featured.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  // getEProviderMostRatedEServices
  Future<List<EService>> getEProviderPopularEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/popular.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getEProviderAvailableEServices(String? eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<EService> _services = response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
      _services = _services.where((_service) {
        return _service.eProvider.available;
      }).toList();
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getEProviderMostRatedEServices(String eProviderId) async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<EService> _services = response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
      _services.sort((s1, s2) {
        return s2.rate!.compareTo(s1.rate!);
      });
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getEProviderEServicesWithPagination(String? eProviderId, int? page) async {
    var response = await httpClient.get(baseUrl + "services/all_page_$page.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Review>> getEServiceReviews(String? eServiceId) async {
    var response = await httpClient.get(baseUrl + "services/reviews.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<Review>((obj) => Review.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getFeaturedEServices() async {
    var response = await httpClient.get(baseUrl + "services/featured.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getPopularEServices() async {
    var response = await httpClient.get(baseUrl + "services/popular.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getMostRatedEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<EService> _services = response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
      _services.sort((s1, s2) {
        return s2.rate!.compareTo(s1.rate!);
      });
      return _services;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getAvailableEServices() async {
    var response = await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      List<EService> _services = response.data['data'].map<EService>((obj) => EService.fromJson(obj)).toList();
      _services = _services.where((_service) {
        return _service.eProvider.available!;
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

  Future<List<NotificationModel>> getNotifications() async {
    var response = await httpClient.get(baseUrl + "notifications/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<NotificationModel>((obj) => NotificationModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<FaqCategory>> getCategoriesWithFaqs() async {
    var response = await httpClient.get(baseUrl + "help/faqs.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data'].map<FaqCategory>((obj) => FaqCategory.fromJson(obj)).toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<Setting> getSettings() async {
    var response = await httpClient.get(baseUrl + "settings/all.json", options: _options);
    if (response.statusCode == 200) {
      return Setting.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }
}