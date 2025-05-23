// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../caches/WOHBuildCacheOptions.dart';
import '../../common/WOHCustomTrace.dart';
import '../exceptions/WOHNetworkExceptions.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

// + |
class WOHDioClient {
  final String baseUrl;

  late Dio _dio;
  late Options optionsNetwork;
  late Options optionsCache;
  final List<Interceptor> interceptors;
  final _progress = <String>[].obs;

  WOHDioClient(this.baseUrl, Dio? dio, {required this.interceptors}) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout = Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
        'Accept-Language': 'en',
      };
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false,
        ),
      );
    }
    optionsNetwork = Options(headers: _dio.options.headers);
    optionsCache = Options(headers: _dio.options.headers);
    if (!kIsWeb && !kDebugMode) {
      // optionsNetwork = buildCacheOptions(
      //   Duration(days: 3),
      //   forceRefresh: true,
      //   options: optionsNetwork,
      // );
      // optionsCache = buildCacheOptions(
      //   Duration(minutes: 10),
      //   forceRefresh: false,
      //   options: optionsCache,
      // );
      _dio.interceptors.add(
        DioCacheInterceptor(options: cacheOptions),
        // DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor
      );
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> getUri(
    Uri uri, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    WOHCustomTrace programInfo = WOHCustomTrace(StackTrace.current);
    try {
      _startProgress(programInfo);
      var response = await _dio.getUri(
        uri,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      _endProgress(programInfo);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } on FlutterError catch (e) {
      print(e.runtimeType);
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    } finally {
      _endProgress(programInfo);
    }
  }

  void _endProgress(WOHCustomTrace programInfo) {
    try {
      _progress.remove(_getTaskName(programInfo));
    } on FlutterError {}
  }

  void _startProgress(WOHCustomTrace programInfo) {
    try {
      _progress.add(_getTaskName(programInfo));
    } on FlutterError {}
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> postUri(
    Uri uri, {
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    WOHCustomTrace programInfo = WOHCustomTrace(StackTrace.current);
    try {
      _startProgress(programInfo);
      var response = await _dio.postUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _endProgress(programInfo);
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    } finally {
      _endProgress(programInfo);
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> putUri(
    Uri uri, {
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    WOHCustomTrace programInfo = WOHCustomTrace(StackTrace.current);
    try {
      _startProgress(programInfo);
      var response = await _dio.putUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _endProgress(programInfo);
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    } finally {
      _endProgress(programInfo);
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> patchUri(
    Uri uri, {
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    WOHCustomTrace programInfo = WOHCustomTrace(StackTrace.current);
    try {
      _startProgress(programInfo);
      var response = await _dio.patchUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _endProgress(programInfo);
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    } finally {
      _endProgress(programInfo);
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> deleteUri(
    Uri uri, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    WOHCustomTrace programInfo = WOHCustomTrace(StackTrace.current);
    try {
      _startProgress(programInfo);
      var response = await _dio.deleteUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      _endProgress(programInfo);
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw WOHNetworkExceptions.getDioException(e);
    } finally {
      _endProgress(programInfo);
    }
  }

  bool isLoading({required String task, required List<String> tasks}) {
    return _progress.any((_task) => _progress.contains(_task));
   // return _progress.contains(task);
  }

  String _getTaskName(programInfo) {
    return programInfo.callerFunctionName.split('.')[1];
  }
}

/*
*     (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String? host, int? port) => true;
      return client;
    };
*
* */