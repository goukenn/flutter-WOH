// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../../models/WOHNotificationModel.dart' as model;

class WOHNotificationItemWidget extends StatelessWidget {
  WOHNotificationItemWidget({Key key, this.notification, this.onDismissed, this.onTap, this.icon}) : super(key: key);
  final model.WOHNotificationModel notification;
  final ValueChanged<model.WOHNotificationModel> onDismissed;
  final ValueChanged<model.WOHNotificationModel> onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.notification.hashCode.toString()),
      background: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: WOHUi.getBoxDecoration(color: Colors.red),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        onDismissed(this.notification);
        // Then show a snackbar
      },
      child: GestureDetector(
        onTap: () {
          onTap(notification);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: WOHUi.getBoxDecoration(color: this.notification.isSeen ? Get.theme.primaryColor : Get.theme.focusColor.withAlpha((255 * 0.15).toInt())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                          notification.isSeen ? Get.theme.focusColor.withAlpha((255 * 0.6).toInt()) : Get.theme.focusColor.withAlpha((255 * 1).toInt()),
                          notification.isSeen ? Get.theme.focusColor.withAlpha((255 * 0.1).toInt()) : Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                          // Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                        ])),
                    child: icon ??
                        Icon(
                          Icons.notifications_outlined,
                          color: Get.theme.scaffoldBackgroundColor,
                          size: 38,
                        ),
                  ),
                  Positioned(
                    right: -15,
                    bottom: -30,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withAlpha((255 * 0.15).toInt()),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -55,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withAlpha((255 * 0.15).toInt()),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      this.notification.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontWeight: notification.isSeen ? FontWeight.normal : FontWeight.bold, fontSize: 14, color: buttonColor),
                    ),
                    Text(
                      this.notification.message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Get.textTheme.bodyLarge!.merge(TextStyle(fontWeight: notification.isSeen ? FontWeight.normal : FontWeight.w600,fontSize: 12, color: Colors.black87)),
                    ),
                    Text(
                      // DateFormat('d, MMMM y | HH:mm', Get.locale.toString()).format(this.notification.timestamp),
                      notification.timestamp.toString(),
                      style: Get.textTheme.labelSmall,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}