// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHBookingModel.dart';
import '../../../models/WOHNotificationModel.dart' as model;
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../root/controllers/WOHRootController.dart';
import '../../userBookings/controllers/WOHBookingsController.dart';
import '../controllers/WOHNotificationsController.dart';
import 'WOHNotificationItemWidget.dart';

class WOHBookingNotificationItemWidget extends GetView<NotificationsController> {
  WOHBookingNotificationItemWidget({Key key, this.notification}) : super(key: key);
  final model.NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return NotificationItemWidget(
      notification: notification,
      onDismissed: (notification) {
        controller.removeNotification(notification);
      },
      icon: Icon(
        Icons.assignment_outlined,
        color: Get.theme.scaffoldBackgroundColor,
        size: 34,
      ),
      onTap: (notification) async {
        print(notification.message);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Loading data..."),
          duration: Duration(seconds: 3),
        ));

        await controller.markAsReadNotification(notification);

        var id;
        if (notification.id != null &&
            notification.title.contains('A new Shipping has been created')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }

        if (notification.id != null &&
            notification.title.contains('Shipping has been Paid')) {
          id = notification.message.toString().substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }
        if (notification.id != null &&
            notification.title.contains('Shipping Cancelled')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }
        if (notification.id != null &&
            notification.title.contains('Packages has been delivered')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }
        if (notification.id != null &&
            notification.title.contains('Shipping has been rated')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }
        if (notification.id != null &&
            notification.title.contains('Shipping rejected')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }
        if (notification.id != null &&
            notification.title.contains('Packages has been received')) {
          id = notification.message.substring(
              notification.message.lastIndexOf(':') + 2,
              notification.message.length - 1);
        }

      },
    );
  }
}