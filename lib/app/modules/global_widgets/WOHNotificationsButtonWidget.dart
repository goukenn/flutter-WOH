// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../routes/WOHRoutes.dart';
import '../../services/WOHAuthService.dart';
import '../../services/WOHMyAuthService.dart';
import '../root/controllers/WOHRootController.dart';

class WOHNotificationsButtonWidget extends GetView<RootController> {
  const WOHNotificationsButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  Widget build(BuildContext context) {
    return MaterialButton(
      hoverElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      onPressed: () async {
        print(Get.find<MyAuthService>().myUser.value.email.toString());
        //if (Get.find<MyAuthService>().myUser.value.email != null ) {
          await Get.toNamed(WOHRoutes.NOTIFICATIONS);
        //}
        // else {
        //   await Get.toNamed(WOHRoutes.LOGIN);
        // }
      },
      child: Obx(() => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 28,
          ),
          if(controller.notificationsCount.value != 0)
            Container(
              child: Center(
                child: Text(
                  controller.notificationsCount.value.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.labelSmall.merge(
                    TextStyle(color: Get.theme.primaryColor, fontSize: 11, height: 1.4),
                  ),
                ),
              ),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(color: labelColor ?? specialColor, borderRadius: BorderRadius.all(Radius.circular(10))),
              constraints: BoxConstraints(minWidth: 16, maxWidth: 20, minHeight: 16, maxHeight: 20),
            ),
        ],
      )
      ),
      color: Colors.transparent,
    );
  }
}