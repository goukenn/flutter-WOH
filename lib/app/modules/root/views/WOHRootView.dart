// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../global_widgets/WOHCustomBottomNavBar.dart';
import '../../global_widgets/main_drawer_widget.dart';
import '../controllers/WOHRootController.dart';

class RootView extends GetView<RootController> {
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
        bottomNavigationBar: CustomBottomNavigationBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          itemColor: context.theme.colorScheme.secondary,
          currentIndex: controller.currentIndex.value,
          onChange: (index) {
            controller.changePage(index);
          },
          children: [
            CustomBottomNavigationItem(
              icon: FontAwesomeIcons.home,
              label: "Accueil".tr,
            ),
            CustomBottomNavigationItem(
              icon: FontAwesomeIcons.fileLines,
              label: "rendez-vous".tr,
            ),
            CustomBottomNavigationItem(
              icon: FontAwesomeIcons.qrcode,
              label: "notification".tr,
            ),
            CustomBottomNavigationItem(
              icon: FontAwesomeIcons.userEdit,
              label: "Compte".tr,
            ),
          ],
        ),
      );
    });
  }
}