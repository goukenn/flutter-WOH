// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../WOHConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../../models/WOHNotificationModel.dart';
import '../../../repositories/WOHNotificationRepository.dart';
import '../../root/controllers/WOHRootController.dart';
import 'package:http/http.dart' as http;

class WOHNotificationsController extends GetxController {
  final notifications = [].obs;
  final travelId = 0.obs;
  final chatInfo = {}.obs;
  late WOHNotificationRepository _notificationRepository;

  WOHNotificationsController() {
    _notificationRepository = new WOHNotificationRepository();
  }

  @override
  void onInit() async {
    await refreshNotifications();
    super.onInit();
  }

  Future refreshNotifications({bool showMessage=true}) async {
    //await getBackgroundMessage();
    notifications.clear();
    var backendList = await getNotifications();
    //
    for (var i = 0; i < backendList.length; i++) {
        notifications.add(backendList[backendList.length-i-1]);
    }
    Get.find<WOHRootController>().getNotificationsCount();
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of notifications refreshed successfully".tr));
    }
  }

  Future getNotifications() async {


    await getBackgroundMessage();

    var list = [];

    for (var i = 0; i < WOHConstants.myBoxStorage.value.length; i++) {
      WOHNotificationModel model = WOHNotificationModel(
       id: WOHConstants.myBoxStorage.value.getAt(i)['id'] ,
        disable: WOHConstants.myBoxStorage.value.getAt(i)['disable'],
        isSeen: WOHConstants.myBoxStorage.value.getAt(i)['isSeen'],
        message: WOHConstants.myBoxStorage.value.getAt(i)['message'],
        timestamp: WOHConstants.myBoxStorage.value.getAt(i)['timestamp'].toString(),
        title: WOHConstants.myBoxStorage.value.getAt(i)['title']
      );
      list.add(model);
    }

    return list;

  }

  getBackgroundMessage() async {
    if (!Hive.isBoxOpen('backgroundMessage')) {
      await Hive.openBox('backgroundMessage');
    }

    for (int j = 0; j < Hive.box("backgroundMessage").length; j++) {

        WOHConstants.myBoxStorage.value.add(Hive.box("backgroundMessage").getAt(j));

      }

    await Hive.box("backgroundMessage").clear();
    await Hive.box("backgroundMessage").close();
  }



  Future removeNotification(WOHNotificationModel notification) async {
    for (var i = 0; i < WOHConstants.myBoxStorage.value.length; i++) {
      if(WOHConstants.myBoxStorage.value.getAt(i)['id'] == notification.id)
      {
        WOHConstants.myBoxStorage.value.deleteAt(i);
      }

    }
    await refreshNotifications();



  }

  Future markAsReadNotification(WOHNotificationModel notification) async {
    for (var i = 0; i < WOHConstants.myBoxStorage.value.length; i++) {
      if(WOHConstants.myBoxStorage.value.getAt(i)['id'] == notification.id)
      {
        final remoteModel = WOHNotificationModel(
          title: notification.title.toString(),
          id: notification.id,
          isSeen: true,
          message: notification.message,
          timestamp: notification.timestamp,
          disable: false,
        );
        WOHConstants.myBoxStorage.value.putAt(i, remoteModel.toJson());
      }

    }
    await refreshNotifications();


  }


  Future getTravelInfo(int id)async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization,
      'Cookie': 'session_id=7c27b4e93f894c9b8b48cad4e00bb4892b5afd83'
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort}/read/m1st_hk_roadshipping.travelbooking?ids=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return json.decode(data)[0];
    }
    else {
      var data = await response.stream.bytesToString();
      //isLoading.value = false;
      //print(data);
    }
  }

  getSingleShipping(int id) async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort}/read/m1st_hk_roadshipping.shipping?ids=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      return json.decode(result)[0];
    }
    else {
      print(response.reasonPhrase);
    }

  }

}