// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:convert';

import 'package:dio/dio.dart' as dio;



import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';

import '../../caches/WOHBuildCacheOptions.dart';
import '../models/WOHAddressModel.dart';
import '../models/WOHAwardModel.dart';
import '../models/WOHBookingModel.dart';
import '../models/WOHCategoryModel.dart';
import '../models/WOHCouponModel.dart';
import '../models/WOHCustomPageModel.dart';
import '../models/WOHEProviderModel.dart';
import '../models/WOHEServiceModel.dart';
import '../models/WOHExperienceModel.dart';
import '../models/WOHFaqCategoryModel.dart';
import '../models/WOHFaqModel.dart';
import '../models/WOHFavoriteModel.dart';
import '../models/WOHGalleryModel.dart';
import '../models/WOHNotificationModel.dart';
import '../models/WOHOptionGroupModel.dart';
import '../models/WOHPaymentMethodModel.dart';
import '../models/WOHPaymentModel.dart';
import '../models/WOHReviewModel.dart';
import '../models/WOHSettingModel.dart';
import '../models/WOHSlideModel.dart';
import '../models/WOHUserModel.dart';
import '../models/WOHWalletModel.dart';
import '../models/WOHWalletTransactionModel.dart';
import '../services/WOHMyAuthService.dart';
import '../services/WOHSettingsService.dart';
import 'WOHApiClient.dart';
import 'WOHDioClient.dart';

class WOHLaravelApiClientProvider extends GetxService with WOHApiClient {
  late WOHDioClient _httpClient;
  late dio.Options _optionsNetwork;
  late dio.Options _optionsCache;

  WOHLaravelApiClientProvider() {
    this.baseUrl = this.globalService.global.value.laravelBaseUrl!;
    _httpClient = WOHDioClient(this.baseUrl, new dio.Dio(), interceptors: []);

  }

  Future<WOHLaravelApiClientProvider> init() async {
    _optionsNetwork = _httpClient.optionsNetwork;
    _optionsCache = _httpClient.optionsCache;
    return this;
  }

  bool isLoading({required String task, required List<String> tasks}) {
    return _httpClient.isLoading(task: task, tasks: tasks);
  }

  void setLocale(String locale) {
    _optionsNetwork.headers?['Accept-Language'] = locale;
    _optionsCache.headers?['Accept-Language'] = locale;
  }

  void forceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsCache = dio.Options(headers: _optionsCache.headers);
      _optionsNetwork = dio.Options(headers: _optionsNetwork.headers);
    }
  }

  void unForceRefresh() {
    if (!foundation.kIsWeb && !foundation.kDebugMode) {
      _optionsNetwork = buildCacheOptions(); //Duration(days: 3), forceRefresh: true, options: _optionsNetwork);
      _optionsCache = buildCacheOptions(); // Duration(minutes: 10), forceRefresh: false, options: _optionsCache);
    }
  }

  Future<List<WOHSlideModel>> getHomeSlider() async {
    Uri _uri = getApiBaseUri("slides");
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHSlideModel>((obj) => WOHSlideModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHUserModel> getUser(WOHUserModel user) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("user").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(
      _uri,
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return WOHUserModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHUserModel> login(WOHUserModel user) async {
    Uri _uri = getApiBaseUri("login");
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return WOHUserModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHUserModel> register(WOHUserModel user) async {
    Uri _uri = getApiBaseUri("register");
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return WOHUserModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> sendResetLinkEmail(WOHUserModel user) async {
    Uri _uri = getApiBaseUri("send_reset_link_email");
    Get.log(_uri.toString());
    // to remove other attributes from the user object
    user = new WOHUserModel(email: user.email);
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHUserModel> updateUser(WOHUserModel user) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ updateUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("users/${user.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(user.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return WOHUserModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteUser(WOHUserModel user) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ deleteUser() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("users").replace(queryParameters: _queryParameters);
    var response = await _httpClient.deleteUri(
      _uri,
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHAddressModel>> getAddresses() async {
    if (Get.find<WOHMyAuthService>().myUser.value.email == null) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getAddresses() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'search': "user_id:${authService.user.value.id}",
      'searchFields': 'user_id:=',
      'orderBy': 'id',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("addresses").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHAddressModel>((obj) => WOHAddressModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getRecommendedEServices() async {
    final _address = Get.find<WOHSettingsService>().address.value;
    // TODO get Only Recommended
    var _queryParameters = {
      'only': 'id;name;price;discount_price;price_unit;has_media;media;total_reviews;rate',
      'with': 'eProvider',
      'limit': '6',
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getAllEServicesWithPagination(String categoryId, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> searchEServices(String keywords, List<String> categories, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    // TODO Pagination
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:${categories.join(',')};name:$keywords',
      'searchFields': 'categories.id:in;name:like',
      'searchJoin': 'and',
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHFavoriteModel>> getFavoritesEServices() async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getFavoritesEServices() ]");
    }
    var _queryParameters = {
      'with': 'eService;options;eService.eProvider',
      'search': 'user_id:${authService.user.value.id}',
      'searchFields': 'user_id:=',
      'orderBy': 'created_at',
      'sortBy': 'desc',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("favorites").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHFavoriteModel>((obj) => WOHFavoriteModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHFavoriteModel> addFavoriteEService(WOHFavoriteModel favorite) async {
    if (!authService.isAuth) {
      throw new Exception("You must have an account to be able to add services to favorite".tr + "[ addFavoriteEService() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("favorites").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(
      _uri,
      data: json.encode(favorite.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      response.data['data']['auth'] = true;
      return WOHFavoriteModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> removeFavoriteEService(WOHFavoriteModel favorite) async {
    if (!authService.isAuth) {
      throw new Exception("You must have an account to be able to add services to favorite".tr + "[ removeFavoriteEService() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("favorites/1").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(
      _uri,
      data: json.encode(favorite.toJson()),
      options: _optionsNetwork,
    );
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHEServiceModel> getEService(String id) async {
    var _queryParameters = {
      'with': 'eProvider;eProvider.taxes;categories',
    };
    if (authService.isAuth) {
      _queryParameters['api_token'] = authService.apiToken;
    }
    Uri _uri = getApiBaseUri("e_services/$id").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHEServiceModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHEProviderModel> getEProvider(String eProviderId) async {
    const _queryParameters = {
      'with': 'eProviderType;availabilityHours;users;addresses',
    };
    Uri _uri = getApiBaseUri("e_providers/$eProviderId").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHEProviderModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHReviewModel>> getEProviderReviews(String eProviderId) async {
    var _queryParameters = {'with': 'eProviderReviews;eProviderReviews.user', 'only': 'eProviderReviews.id;eProviderReviews.review;eProviderReviews.rate;eProviderReviews.user;'};
    Uri _uri = getApiBaseUri("e_providers/$eProviderId").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data']['e_provider_reviews'].map<WOHReviewModel>((obj) => WOHReviewModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHGalleryModel>> getEProviderGalleries(String eProviderId) async {
    var _queryParameters = {
      'with': 'media',
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("galleries").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHGalleryModel>((obj) => WOHGalleryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHAwardModel>> getEProviderAwards(String eProviderId) async {
    var _queryParameters = {
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("awards").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHAwardModel>((obj) => WOHAwardModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHExperienceModel>> getEProviderExperiences(String eProviderId) async {
    var _queryParameters = {
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("experiences").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHExperienceModel>((obj) => WOHExperienceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderFeaturedEServices(String eProviderId, int? page) async {
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'e_provider_id:$eProviderId;featured:1',
      'searchFields': 'e_provider_id:=;featured:=',
      'searchJoin': 'and',
      'limit': '5',
      'offset': ((page! - 1) * 5).toString()
    };
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderPopularEServices(String eProviderId, int? page) async {
    // TODO popular eServices
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderAvailableEServices(String eProviderId, int? page) async {
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'available_e_provider': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderMostRatedEServices(String eProviderId, int? page) async {
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHUserModel>> getEProviderEmployees(String eProviderId) async {
    var _queryParameters = {'with': 'users', 'only': 'users;users.id;users.name;users.email;users.phone_number;users.device_token'};
    Uri _uri = getApiBaseUri("e_providers/$eProviderId").replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data']['users'].map<WOHUserModel>((obj) => WOHUserModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getEProviderEServices(String eProviderId, int? page) async {
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'e_provider_id:$eProviderId',
      'searchFields': 'e_provider_id:=',
      'searchJoin': 'and',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHReviewModel>> getEServiceReviews(String eServiceId) async {
    var _queryParameters = {'with': 'user', 'only': 'created_at;review;rate;user', 'search': "e_service_id:$eServiceId", 'orderBy': 'created_at', 'sortBy': 'desc', 'limit': '10'};
    Uri _uri = getApiBaseUri("e_service_reviews").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHReviewModel>((obj) => WOHReviewModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHOptionGroupModel>> getEServiceOptionGroups(String eServiceId) async {
    var _queryParameters = {
      'with': 'options;options.media',
      'only': 'id;name;allow_multiple;options.id;options.name;options.description;options.price;options.option_group_id;options.e_service_id;options.media',
      'search': "options.e_service_id:$eServiceId",
      'searchFields': 'options.e_service_id:=',
      'orderBy': 'name',
      'sortBy': 'desc'
    };
    Uri _uri = getApiBaseUri("option_groups").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHOptionGroupModel>((obj) => WOHOptionGroupModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getFeaturedEServices(String categoryId, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:$categoryId;featured:1',
      'searchFields': 'categories.id:=;featured:=',
      'searchJoin': 'and',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getPopularEServices(String categoryId, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getMostRatedEServices(String categoryId, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      //'only': 'id;name;price;discount_price;price_unit;duration;has_media;total_reviews;rate',
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'rating': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHEServiceModel>> getAvailableEServices(String categoryId, int? page) async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      'with': 'eProvider;eProvider.addresses;categories',
      'search': 'categories.id:$categoryId',
      'searchFields': 'categories.id:=',
      'available_e_provider': 'true',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("e_services").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHEServiceModel>((obj) => WOHEServiceModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCategoryModel>> getAllCategories() async {
    const _queryParameters = {
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri = getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCategoryModel>> getAllParentCategories() async {
    const _queryParameters = {
      'parent': 'true',
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri = getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCategoryModel>> getSubCategories(String categoryId) async {
    final _queryParameters = {
      'search': "parent_id:$categoryId",
      'searchFields': "parent_id:=",
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri = getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCategoryModel>> getAllWithSubCategories() async {
    const _queryParameters = {
      'with': 'subCategories',
      'parent': 'true',
      'orderBy': 'order',
      'sortBy': 'asc',
    };
    Uri _uri = getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCategoryModel>> getFeaturedCategories() async {
    final _address = Get.find<WOHSettingsService>().address.value;
    var _queryParameters = {
      'with': 'featuredEServices',
      'parent': 'true',
      'search': 'featured:1',
      'searchFields': 'featured:=',
      'orderBy': 'order',
      'sortedBy': 'asc',
    };
    if (!_address.isUnknown()) {
      _queryParameters['myLat'] = _address.latitude.toString();
      _queryParameters['myLon'] = _address.longitude.toString();
    }
    Uri _uri = getApiBaseUri("categories").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCategoryModel>((obj) => WOHCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHBookingModel>> getBookings(String statusId, int? page) async {
    var _queryParameters = {
      'with': 'bookingStatus;payment;payment.paymentStatus',
      'api_token': authService.apiToken,
      // 'search': 'user_id:${authService.user.value.id}',
      'search': 'booking_status_id:$statusId',
      'orderBy': 'created_at',
      'sortedBy': 'desc',
      'limit': '4',
      'offset': ((page! - 1) * 4).toString()
    };
    Uri _uri = getApiBaseUri("userBookings").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHBookingModel>((obj) => WOHBookingModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future getBookingStatuses() async {
    /*var _queryParameters = {
      'only': 'id;status;order',
      'orderBy': 'order',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("booking_statuses").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHBookingStatusModel>((obj) => WOHBookingStatusModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }*/
    return [];
  }

  Future<WOHBookingModel> getBooking(String bookingId) async {
    var _queryParameters = {
      'with': 'bookingStatus;user;payment;payment.paymentMethod;payment.paymentStatus',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("userBookings/$bookingId").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHBookingModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHCouponModel> validateCoupon(WOHBookingModel booking) async {
    var _queryParameters = {
      'api_token': authService.apiToken,
      'code': booking.coupon?.code ?? '',
      'e_service_id': booking.eService?.id ?? '',
      'e_provider_id': booking.eService?.eProvider?.id ?? '',
      'categories_id': booking.eService?.categories?.map((e) => e.id).join(",") ?? '',
    };
    Uri _uri = getApiBaseUri("coupons").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHCouponModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHBookingModel> updateBooking(WOHBookingModel booking) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ updateBooking() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("userBookings/${booking.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.putUri(_uri, data: booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHBookingModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHBookingModel> addBooking(WOHBookingModel booking) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ addBooking() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("userBookings").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri, data: booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHBookingModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHReviewModel> addReview(WOHReviewModel review) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ addReview() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("e_service_reviews").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri, data: review.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHReviewModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHPaymentMethodModel>> getPaymentMethods() async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getPaymentMethods() ]");
    }
    var _queryParameters = {
      'with': 'media',
      'search': 'enabled:1',
      'searchFields': 'enabled:=',
      'orderBy': 'order',
      'sortBy': 'asc',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payment_methods").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHPaymentMethodModel>((obj) => WOHPaymentMethodModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHWalletModel>> getWallets() async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getWallets() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHWalletModel>((obj) => WOHWalletModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHWalletModel> createWallet(WOHWalletModel _wallet) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ createWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri, data: _wallet.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHWalletModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHWalletModel> updateWallet(WOHWalletModel _wallet) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ updateWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets/${_wallet.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.putUri(_uri, data: _wallet.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHWalletModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteWallet(WOHWalletModel _wallet) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ deleteWallet() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("wallets/${_wallet.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHWalletTransactionModel>> getWalletTransactions(WOHWalletModel wallet) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getWalletTransactions() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'with': 'user',
      'search': 'wallet_id:${wallet.id}',
      'searchFields': 'wallet_id:=',
    };
    Uri _uri = getApiBaseUri("wallet_transactions").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHWalletTransactionModel>((obj) => WOHWalletTransactionModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHPaymentModel> createPayment(WOHBookingModel _booking) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ createPayment() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payments/cash").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri, data: _booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHPaymentModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHPaymentModel> createWalletPayment(WOHBookingModel _booking, WOHWalletModel _wallet) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ createPayment() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("payments/wallets/${_wallet.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.postUri(_uri, data: _booking.toJson(), options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHPaymentModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  String getPayPalUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getPayPalUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paypal/express-checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getRazorPayUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getRazorPayUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/razorpay/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getStripeUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getStripeUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/stripe/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getPayStackUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getPayStackUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paystack/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getPayMongoUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getPayMongoUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/paymongo/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getFlutterWaveUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getFlutterWaveUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/flutterwave/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  String getStripeFPXUrl(WOHBookingModel _booking) {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getStripeFPXUrl() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
      'booking_id': _booking.id,
    };
    Uri _uri = getBaseUri("payments/stripe-fpx/checkout").replace(queryParameters: _queryParameters);
    return _uri.toString();
  }

  Future<List<WOHNotificationModel>> getNotifications() async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ getNotifications() ]");
    }
    var _queryParameters = {
      'search': 'notifiable_id:${authService.user.value.id}',
      'searchFields': 'notifiable_id:=',
      'searchJoin': 'and',
      'orderBy': 'created_at',
      'sortedBy': 'desc',
      'limit': '50',
      'only': 'id;type;data;read_at;created_at',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHNotificationModel>((obj) => WOHNotificationModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHNotificationModel> markAsReadNotification(WOHNotificationModel notification) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ markAsReadNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/${notification.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    // mark runed pam undefined 
    // var response = await _httpClient.putUri(_uri, data: notification.markReadMap(), options: _optionsNetwork);
    // if (response.data['success'] == true) {
    //   return WOHNotificationModel.fromJson(response.data['data']);
    // } else {
    //   throw new Exception(response.data['message']);
    // }
    throw 'not implements';
  }

  Future<bool> sendNotification(List<WOHUserModel> users, WOHUserModel from, String type, String text, String id) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ sendNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    var data = {
      'users': users.map((e) => e.id).toList(),
      'from': from.id,
      'type': type,
      'text': text,
      'id': id,
    };
    Uri _uri = getApiBaseUri("notifications").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    Get.log(data.toString());
    var response = await _httpClient.postUri(_uri, data: data, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHNotificationModel> removeNotification(WOHNotificationModel notification) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ removeNotification() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/${notification.id}").replace(queryParameters: _queryParameters);
    Get.log(_uri.toString());
    var response = await _httpClient.deleteUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHNotificationModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<int> getNotificationsCount() async {
    print(authService.isAuth);
    if (!authService.isAuth) {
      return 0;
    }
    var _queryParameters = {
      'search': 'notifiable_id:${authService.user.value.id}',
      'searchFields': 'notifiable_id:=',
      'searchJoin': 'and',
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("notifications/count").replace(queryParameters: _queryParameters);

    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHFaqCategoryModel>> getFaqCategories() async {
    var _queryParameters = {
      'orderBy': 'created_at',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("faq_categories").replace(queryParameters: _queryParameters);

    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHFaqCategoryModel>((obj) => WOHFaqCategoryModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHFaqModel>> getFaqs(String categoryId) async {
    var _queryParameters = {
      'search': 'faq_category_id:$categoryId',
      'searchFields': 'faq_category_id:=',
      'searchJoin': 'and',
      'orderBy': 'updated_at',
      'sortedBy': 'desc',
    };
    Uri _uri = getApiBaseUri("faqs").replace(queryParameters: _queryParameters);

    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHFaqModel>((obj) => WOHFaqModel.fromJson(obj)).toList();
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<WOHSettingModel> getSettings() async {
    Uri _uri = getApiBaseUri("settings");

    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return WOHSettingModel.fromJson(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List> getModules() async {
    Uri _uri = getApiBaseUri("modules");

    var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
    if (response.data['success'] == true) {
      return response.data['data'];
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<Map<String, String>> getTranslations(String locale) async {
    var _queryParameters = {
      'locale': locale,
    };
    Uri _uri = getApiBaseUri("translations").replace(queryParameters: _queryParameters);

    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return Map<String, String>.from(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<String>> getSupportedLocales() async {
    Uri _uri = getApiBaseUri("supported_locales");
    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return List.from(response.data['data']);
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<List<WOHCustomPageModel>> getCustomPages() async {
    var _queryParameters = {
      'only': 'id;title',
      'search': 'published:1',
      'orderBy': 'created_at',
      'sortedBy': 'asc',
    };
    Uri _uri = getApiBaseUri("custom_pages").replace(queryParameters: _queryParameters);

    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return response.data['data'].map<WOHCustomPageModel>((obj) => WOHCustomPageModel.fromJson(obj)).toList();
    } else {
      throw new Exception("laravel prov: 1 ${response.data['message']}");
    }
  }

  Future<WOHCustomPageModel> getCustomPageById(String id) async {
    Uri _uri = getApiBaseUri("custom_pages/$id");

    var response = await _httpClient.getUri(_uri, options: _optionsCache);
    if (response.data['success'] == true) {
      return WOHCustomPageModel.fromJson(response.data['data']);
    } else {
      throw new Exception("laravel prov: 2 ${response.data['message']}");
    }
  }

  /*Future<String> uploadImage(File file, String field) async {

    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ uploadImage() ]");
    }
    String fileName = file.path.split('/').last;
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/store").replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(file.path, filename: fileName),
      "uuid": WOHUuid().generateV4(),
      "field": field,
    });
    var response = await _httpClient.postUri(_uri, data: formData);
    print(response.data);
    if (response.data['data'] != false) {
      return response.data['data'];
    } else {
      throw new Exception("laravel prov: 3 images ${response.data['message']}");
    }
  }

  Future<bool> deleteUploaded(String uuid) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ deleteUploaded() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/clear").replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri, data: {'uuid': uuid});
    print(response.data);
    if (response.data['data'] != false) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }

  Future<bool> deleteAllUploaded(List<String> uuids) async {
    if (!authService.isAuth) {
      throw new Exception("You don't have the permission to access to this area!".tr + "[ deleteUploaded() ]");
    }
    var _queryParameters = {
      'api_token': authService.apiToken,
    };
    Uri _uri = getApiBaseUri("uploads/clear").replace(queryParameters: _queryParameters);
    printUri(StackTrace.current, _uri);
    var response = await _httpClient.postUri(_uri, data: {'uuid': uuids});
    print(response.data);
    if (response.data['data'] != false) {
      return true;
    } else {
      throw new Exception(response.data['message']);
    }
  }*/
}