// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, use_key_in_widget_constructors
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