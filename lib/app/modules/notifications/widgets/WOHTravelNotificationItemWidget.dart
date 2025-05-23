// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHNotificationModel.dart' as model;
import '../../../routes/WOHRoutes.dart';
import '../controllers/WOHNotificationsController.dart';

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