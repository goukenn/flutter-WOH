// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHTabBarWidget.dart';
import '../controllers/WOHSettingsController.dart';

class WOHSettingsView extends GetView<SettingsController> {
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Settings".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          bottom: TabBarWidget(
            initialSelectedId: 0,
            tag: 'settings',
            tabs: [
              ChipWidget(
                tag: 'settings',
                text: "Languages".tr,
                id: 0,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Profile".tr,
                id: 1,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              /*ChipWidget(
                tag: 'settings',
                text: "Addresses".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),*/
              ChipWidget(
                tag: 'settings',
                text: "Theme Mode".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              )
            ],
          )),
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey.currentState.canPop()) {
            _navigatorKey.currentState.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: WOHRoutes.SETTINGS_LANGUAGE,
          onGenerateRoute: controller.onGenerateRoute,
        ),
      ),
    );
  }
}