// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHMessageModel.dart';
import '../../../models/WOHNotificationModel.dart' as model;
import '../../../routes/WOHRoutes.dart';
import '../../root/controllers/WOHRootController.dart';
import '../controllers/WOHNotificationsController.dart';
import 'WOHNotificationItemWidget.dart';

class WOHTravelNotificationItemWidget extends GetView<WOHNotificationsController> {
  WOHTravelNotificationItemWidget({super.key, this.notification});
  final model.WOHNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return NotificationItemWidget(
      notification: notification,
      onDismissed: (notification) {
        controller.removeNotification(notification);
      },
      icon: Icon(
        Icons.chat_outlined,
        color: Get.theme.scaffoldBackgroundColor,
        size: 34,
      ),
      onTap: (notification) async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Loading data..."),
          duration: Duration(seconds: 3),
        ));
        await controller.markAsReadNotification(notification);

        print(notification.message);
        var id;
        if(notification.id != null&& notification.title.contains('Travel Create')){
          id = notification.message.substring(notification.message.lastIndexOf(':')+2, notification.message.length-1);
        }
        if(notification.id != null&& notification.title.contains('Travel has been Accepted / Running')){
          id = notification.message.substring(notification.message.lastIndexOf(':')+2, notification.message.length-1);
        }
        if(notification.id != null&& notification.title.contains('Travel has been Completed')){
          id = notification.message.substring(notification.message.lastIndexOf(':')+2, notification.message.length-1);
        }
        if(notification.id != null&& notification.title.contains('Travel has been cancelled')){
          id = notification.message.substring(notification.message.lastIndexOf(':')+2, notification.message.length-1);
        }
        var travel = await controller.getTravelInfo(int.parse(id));
        Get.toNamed(WOHRoutes.TRAVEL_INSPECT, arguments: {'travelCard': travel, 'heroTag': 'services_carousel'});
        //Get.find<WOHRootController>().changePage(2);
        //Get.toNamed(WOHRoutes.CHAT, arguments: new WOHMessageModel([], id: notification.id.toString()));

      },
    );
  }
}