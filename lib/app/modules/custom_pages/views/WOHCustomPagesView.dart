// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * File name: WOHCustomPagesView.dart
 * Last modified: 2022.02.18 at 19:24:11
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../controllers/WOHCustomPagesController.dart';
import '../widgets/WOHCustomPageLoadingWidget.dart';

class WOHCustomPagesView extends GetView<CustomPagesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(
              controller.customPage.value.title.tr,
              style: Get.textTheme.titleLarge,
            );
          }),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => {Get.back()},
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {

          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(() {
              if (controller.customPage.value.content.isEmpty) {
                return CustomPageLoadingWidget();
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: WOHUi.applyHtml(controller.customPage.value.content),
                );
              }
            }),
          ),
        ));
  }
}