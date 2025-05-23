// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../global_widgets/WOHCustomBottomNavBar.dart';
import '../../global_widgets/WOHMainDrawerWidget.dart';
import '../controllers/WOHRootController.dart';

class WOHRootView extends GetView<WOHRootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.lazyPut(()=>MyAuthService());
      Get.lazyPut<WOHOdooApiClientProvider>(
            () => WOHOdooApiClientProvider(),
      );
      return Scaffold(
        drawer: MainDrawerWidget(),
        body: controller.currentPage,
        bottomNavigationBar: WOHCustomBottomNavigationBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          itemColor: context.theme.colorScheme.secondary,
          currentIndex: controller.currentIndex.value,
          onChange: (index) {
            controller.changePage(index);
          },
          children: [
            WOHCustomBottomNavigationItem(
              icon: FontAwesomeIcons.home,
              label: "Accueil".tr,
            ),
            WOHCustomBottomNavigationItem(
              icon: FontAwesomeIcons.fileLines,
              label: "rendez-vous".tr,
            ),
            WOHCustomBottomNavigationItem(
              icon: FontAwesomeIcons.qrcode,
              label: "notification".tr,
            ),
            WOHCustomBottomNavigationItem(
              icon: FontAwesomeIcons.userEdit,
              label: "Compte".tr,
            ),
          ],
        ),
      );
    });
  }
}