// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../controllers/WOHNotificationsController.dart';

class WOHNotificationDetails extends GetView<WOHNotificationsController> {
  var notification;

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      if (arguments['notification'] != null) {
        notification = arguments['notification'];

        Get.lazyPut(() => WOHNotificationsController());

        return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Notification Details".tr,
                  style: Get.textTheme.titleLarge!.merge(
                      TextStyle(color: Colors.white)),
                ),
                centerTitle: true,
                backgroundColor: appBarColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white)
                )
            ),
            bottomSheet:  viewData(
              'sent time :',
              notification.timestamp.toString(),
              FontWeight.bold,
              Colors.grey,
              12,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (notification != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            viewData(
                                '', notification.title, FontWeight.bold, Colors
                                .black, 20),
                            viewData(' ', notification.message, FontWeight
                                .normal,
                                Colors.black, 12),

                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            )

        );
      }
    }
    // + | add explicit throw
    throw '';
  }

  Widget viewData(String title, String value, FontWeight fontWeight,
      Color color,
      double fontSize) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: TextStyle(fontWeight: fontWeight, color: color),
          ),
          Expanded(
              child: Text(value.isEmpty? 'N/A' : value,
                  style: TextStyle(
                      fontWeight: fontWeight,
                      color: color,
                      fontSize: fontSize)))
        ],
      ),
    );
  }
}