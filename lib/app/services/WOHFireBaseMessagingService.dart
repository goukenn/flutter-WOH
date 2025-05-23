// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../WOHColorConstants.dart';
import '../../WOHConstants.dart';
import '../../common/WOHUi.dart'; 
import '../models/WOHMessageModel.dart';
import '../models/WOHNotificationModel.dart';
import '../modules/notifications/controllers/WOHNotificationsController.dart';
import '../modules/root/controllers/WOHRootController.dart';
import '../routes/WOHRoutes.dart';

class WOHFireBaseMessagingService extends GetxService {
  Future<WOHFireBaseMessagingService> init() async {
    //`FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);
    requestPermission();
    await setDeviceToken();
    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await fcmOnMessageListeners();
    return this;
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("WOHUserModel? permission granted");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("user granted a provisional permission ");
      }
    } else {
      if (kDebugMode) {
        print("user did not granted permission");
      }

      showDialog(
        context: Get.context!,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 170,
              padding: EdgeInsets.all(10),
              child: Text(
                'Allow your device to receive notifications from Hubkilo in the device settings',
                style: Get.textTheme.displayLarge!.merge(
                  TextStyle(fontSize: 15, color: buttonColor),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Future fcmOnMessageListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Get.isRegistered<WOHRootController>()) {
        //Get.find<WOHRootController>().getNotificationsCount();
      }
      if (message.data['id'] == "App\\Notifications\\NewMessage") {
        _newMessageNotification(message);
      } else {
        _bookingNotification(message);
      }
      var count = 0;
      WOHNotificationsController _notificationController =
          new WOHNotificationsController();

      final remoteModel = WOHNotificationModel(
        title: message.notification?.title.toString(),
        id: message.messageId.toString(),
        isSeen: false,
        message: message.notification?.body.toString(),
        timestamp: message.sentTime.toString(),
        disable: false,
      );

      WOHConstants.myBoxStorage.value.add(remoteModel.toJson());
      print('hey');
      print(WOHConstants.myBoxStorage.value.getAt(0));
      print('hey');

      for (int i = 0; i < WOHConstants.myBoxStorage.value.length; i++) {
        //print(WOHConstants.myBoxStorage.getAt(i));
        if (WOHConstants.myBoxStorage.value.getAt(i)['isSeen'] == false) {
          count = count + 1;
        }
      }
      print('hey: $count');
      Get.find<WOHRootController>().notificationsCount.value = count;
    });
  }

  Future fcmOnLaunchListeners() async {
    RemoteMessage? message = await FirebaseMessaging.instance
        .getInitialMessage();
    if (message != null) {
      _notificationsBackground(message);
    }
  }

  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var count = 0;
      // WOHNotificationsController _notificationController = new WOHNotificationsController();

      if (!Hive.isBoxOpen('backgroundMessage')) {
        await Hive.openBox('backgroundMessage');
      }

      for (int j = 0; j < Hive.box("backgroundMessage").length; j++) {
        if (Hive.box("backgroundMessage").getAt(j)['isSeen'] == false) {
          count = count + 1;
        }
      }
      for (int i = 0; i < WOHConstants.myBoxStorage.value.length; i++) {
        //print(WOHConstants.myBoxStorage.getAt(i));
        if (WOHConstants.myBoxStorage.value.getAt(i)['isSeen'] == false) {
          count = count + 1;
        }
      }
      Get.find<WOHRootController>().notificationsCount.value = count;

      _notificationsBackground(message);
    });
  }

  void _notificationsBackground(RemoteMessage message) {
    if (message.data['id'] == "App\\Notifications\\NewMessage") {
      _newMessageNotificationBackground(message);
    } else {
      _newBookingNotificationBackground(message);
    }
  }

  void _newBookingNotificationBackground(message) {
    if (Get.isRegistered<WOHRootController>()) {
      //Get.toNamed(WOHRoutes.BOOKING, arguments: new WOHBookingModel(id: message.data['bookingId']));
    }
  }

  void _newMessageNotificationBackground(RemoteMessage message) {
    if (message.data['messageId'] != null) {
      Get.toNamed(
        WOHRoutes.CHAT,
        arguments: new WOHMessageModel([], id: message.data['messageId']),
      );
    }
  }

  Future<void> setDeviceToken() async {
    //Get.find<WOHAuthService>().user.value.deviceToken =
    getToken();
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      var mtoken = token;
      if (kDebugMode) {
        print("my token is $mtoken");
      }
      WOHConstants.deviceToken = token;
    });
  }

  void _bookingNotification(RemoteMessage message) {
    if (Get.currentRoute == WOHRoutes.ROOT) {
      //Get.find<WOHBookingsController>().refreshBookings();
    }
    /*if (Get.currentRoute == WOHRoutes.BOOKING) {
      Get.find<WOHBookingsController>().refreshBooking();
    }*/
    RemoteNotification notification = message.notification!;
    Get.showSnackbar(
      WOHUi.notificationSnackBar(
        title: notification.title!,
        message: notification.body!,
        mainButton: Image.asset(
          'assets/img/willonhair.png',
          fit: BoxFit.cover,
          width: 30,
          height: 30,
        ),
        onTap: (getBar) async {
          if (message.data['bookingId'] != null) {
            // await
            Get.back();
            //Get.toNamed(WOHRoutes.BOOKING, arguments: new WOHBookingModel(id: message.data['bookingId']));
          }
        },
      ),
    );
  }

  void _newMessageNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    if (Get.currentRoute != WOHRoutes.CHAT) {
      Get.showSnackbar(
        WOHUi.notificationSnackBar(
          title: notification.title!,
          message: notification.body!,
          mainButton: Image.asset(
            'assets/img/willonhair.png',
            fit: BoxFit.cover,
            width: 30,
            height: 30,
          ),
          onTap: (getBar) async {
            if (message.data['messageId'] != null) {
              // await
              Get.back();
              Get.toNamed(
                WOHRoutes.CHAT,
                arguments: new WOHMessageModel(
                  [],
                  id: message.data['messageId'],
                ),
              );
            }
          },
        ),
      );
    }
  }
}