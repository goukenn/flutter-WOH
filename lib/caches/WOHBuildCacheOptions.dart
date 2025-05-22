// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

Options buildCacheOptions(){
  return cacheOptions.toOptions();
}

final cacheOptions = CacheOptions(
  policy: CachePolicy.forceCache, // or .request, .refresh, etc.
  maxStale: Duration(days: 7), 
  store: null,
);