// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/WOHNotificationModel.dart' as model;
import '../../../routes/WOHRoutes.dart';
import '../controllers/WOHNotificationsController.dart';
import 'WOHNotificationItemWidget.dart';

class WOHNewPriceNotificationItemWidget extends GetView<WOHNotificationsController> {
  WOHNewPriceNotificationItemWidget({super.key, required this.notification});
  final model.WOHNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return WOHNotificationItemWidget(
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
          duration: Duration(seconds: 12),
        ));
        await controller.markAsReadNotification(notification);
        print(notification.message);
        //await controller.getSpecificShipping(notification.message);
        //Get.find<MessagesController>().card.value = await controller.getTravelInfo(controller.travelId.value);
        var id = notification.message!.substring(notification.message!.lastIndexOf(':')+2, notification.message!.length-1);
        print('id id :'+id.toString());
        print('message :'+notification.message.toString());
       var item = await controller.getSingleShipping(int.parse(id));
        Get.toNamed(WOHRoutes.CHAT, arguments: {'shippingCard': item});
        //Get.toNamed(WOHRoutes.CHAT, arguments: new WOHMessageModel([], id: notification.id.toString()));

      },
    );
  }
}