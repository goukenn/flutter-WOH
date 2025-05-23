// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../controllers/WOHNotificationsController.dart';
import '../widgets/WOHNotificationItemWidget.dart';

class WOHNotificationsView extends GetView<WOHNotificationsController> {
  @override
  Widget build(BuildContext context) {

    Get.lazyPut(()=>WOHNotificationsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications".tr,
          style: Get.textTheme.titleLarge!.merge(TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)
        )
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<WOHLaravelApiClientProvider>().forceRefresh();
          await controller.refreshNotifications(showMessage: true);
          Get.find<WOHLaravelApiClientProvider>().unForceRefresh();
        },
        child: ListView(
          primary: true,
          children: <Widget>[
            notificationsList(),
          ],
        ),
      ),
    );
  }

  Widget notificationsList() {
    return Obx(() {
      if (!controller.notifications.isNotEmpty) {
        return WOHCircularLoadingWidget(
          height: 300,
          onCompleteText: "Notification List is Empty".tr,
        );
      } else {
        var _notifications = controller.notifications;
        return ListView.separated(
            itemCount: _notifications.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 7);
            },
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              var _notification = controller.notifications.elementAt(index);
                return WOHNotificationItemWidget(
                  notification: _notification,
                  onDismissed: (notification) {
                    controller.removeNotification(notification);
                  },
                  onTap: (notification) async {
                    Get.toNamed(WOHRoutes.NOTIFICATION_DETAIL, arguments: {'notification': _notification});
                    await controller.markAsReadNotification(notification);

                  },
                );
              }
            );
      }
    });
  }
}