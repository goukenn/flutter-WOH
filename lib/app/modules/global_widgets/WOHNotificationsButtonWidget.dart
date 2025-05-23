// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../routes/WOHRoutes.dart'; 
import '../../services/WOHMyAuthService.dart';
import '../root/controllers/WOHRootController.dart';

class WOHNotificationsButtonWidget extends GetView<WOHRootController> {
  const WOHNotificationsButtonWidget({
    this.iconColor,
    this.labelColor,
    super.key,
  });

  final Color iconColor;
  final Color labelColor;

  Widget build(BuildContext context) {
    return MaterialButton(
      hoverElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      onPressed: () async {
        print(Get.find<WOHMyAuthService>().myUser.value.email.toString());
        //if (Get.find<WOHMyAuthService>().myUser.value.email != null ) {
          await Get.toNamed(WOHRoutes.NOTIFICATIONS);
        //}
        // else {
        //   await Get.toNamed(WOHRoutes.LOGIN);
        // }
      },
      color: Colors.transparent,
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
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(color: labelColor ?? specialColor, borderRadius: BorderRadius.all(Radius.circular(10))),
              constraints: BoxConstraints(minWidth: 16, maxWidth: 20, minHeight: 16, maxHeight: 20),
              child: Center(
                child: Text(
                  controller.notificationsCount.value.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.labelSmall!.merge(
                    TextStyle(color: Get.theme.primaryColor, fontSize: 11, height: 1.4),
                  ),
                ),
              ),
            ),
        ],
      )
      ),
    );
  }
}