// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as _get;
import '../routes/WOHRoutes.dart';

abstract class WOHNetworkExceptions {
  static String handleResponse(Response response) {
    int statusCode = response.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        _get.Get.offAllNamed(WOHRoutes.LOGIN);
        return "Unauthorized Request";
      case 404:
        return "Not found";
      case 409:
        return "Error due to a conflict";
      case 408:
        return "Connection request timeout";
      case 500:
        return "Internal Server Error";
      case 503:
        return "Service unavailable";
      default:
        return "Received invalid status code";
    }
  }

  static String getDioException(error) {
    if (error is Exception) {
      try {
        var errorMessage = "";

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorMessage = "Request Cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = "Connection request timeout";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            case DioExceptionType.unknown:
              errorMessage = "No internet connection";
              break;
            case DioExceptionType.badResponse:
              errorMessage = WOHNetworkExceptions.handleResponse(error.response!);
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = "Send timeout in connection with API server";
              break;
            default:
              errorMessage = "Other error";
           
            break;
          }
        } else if (error is SocketException) {
          errorMessage = "No internet connection";
        } else {
          errorMessage = "Unexpected error occurred";
        }
        return errorMessage;
      } on FormatException {
        return "Unexpected error occurred";
      } catch (_) {
        return "Unexpected error occurred";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "Unable to process the data";
      } else {
        return "Unexpected error occurred";
      }
    }
  }
}