// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../models/WOHNotificationModel.dart';
import '../models/WOHUserModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHNotificationRepository {
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHNotificationRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHNotificationModel>> getAll() {
    return _laravelApiClient.getNotifications();
  }

  Future<WOHNotificationModel> remove(WOHNotificationModel notification) {
    return _laravelApiClient.removeNotification(notification);
  }

  Future<WOHNotificationModel> markAsRead(WOHNotificationModel notification) {
    return _laravelApiClient.markAsReadNotification(notification);
  }

  Future<bool> sendNotification(List<WOHUserModel> users, WOHUserModel from, String type, String text, String id) {
    return _laravelApiClient.sendNotification(users, from, type, text, id);
  }
}