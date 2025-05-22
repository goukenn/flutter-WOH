// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../controllers/WOHThemeModeController.dart';

class ThemeModeView extends GetView<ThemeModeController> {
  final bool hideAppBar;

  ThemeModeView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Theme Mode".tr,
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
              ),
        body: ListView(
          primary: true,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: WOHUi.getBoxDecoration(),
              child: Column(
                children: [
                  RadioListTile(
                    value: ThemeMode.light,
                    groupValue: controller.selectedThemeMode.value,
                    activeColor: Get.theme.colorScheme.secondary,
                    onChanged: (value) {
                      controller.changeThemeMode(value);
                    },
                    title: Text("Light Theme".tr, style: Get.textTheme.bodyText2),
                  ),
                  RadioListTile(
                    value: ThemeMode.dark,
                    groupValue: controller.selectedThemeMode.value,
                    activeColor: Get.theme.colorScheme.secondary,
                    onChanged: (value) {
                      controller.changeThemeMode(value);
                    },
                    title: Text("Dark Theme".tr, style: Get.textTheme.bodyText2),
                  ),
                  RadioListTile(
                    value: ThemeMode.system,
                    groupValue: controller.selectedThemeMode.value,
                    activeColor: Get.theme.colorScheme.secondary,
                    onChanged: (value) {
                      controller.changeThemeMode(value);
                    },
                    title: Text("System Theme".tr, style: Get.textTheme.bodyText2),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}