// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHTabBarWidget.dart';
import '../controllers/WOHSettingsController.dart';

class WOHSettingsView extends GetView<WOHSettingsController> {
  final _navigatorKey = Get.nestedKey(1);

  WOHSettingsView({super.key});

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
          bottom: WOHTabBarWidget(
            initialSelectedId: 0,
            tag: 'settings',
            tabs: [
              WOHChipWidget(
                tag: 'settings',
                text: "Languages".tr,
                id: 0,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              WOHChipWidget(
                tag: 'settings',
                text: "Profile".tr,
                id: 1,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              /*WOHChipWidget(
                tag: 'settings',
                text: "Addresses".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),*/
              WOHChipWidget(
                tag: 'settings',
                text: "Theme Mode".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              )
            ],
          )),
      body: /*WillPopScope*/ PopScope(
        onWillPop: () async {
          if (_navigatorKey!.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
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