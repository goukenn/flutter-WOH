// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHAuthService.dart'; 
import '../../global_widgets/WOHCustomBottomNavBar.dart';
import '../../global_widgets/WOHMainDrawerWidget.dart';
import '../controllers/WOHRootController.dart';

class WOHRootView extends GetView<WOHRootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.lazyPut(()=>WOHAuthService());
      Get.lazyPut<WOHOdooApiClientProvider>(
            () => WOHOdooApiClientProvider(),
      );
      return Scaffold(
        drawer: WOHMainDrawerWidget(),
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
              icon: FontAwesomeIcons.house,
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
              icon: FontAwesomeIcons.pen,
              label: "Compte".tr,
            ),
          ],
        ),
      );
    });
  }
}