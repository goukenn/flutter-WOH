// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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