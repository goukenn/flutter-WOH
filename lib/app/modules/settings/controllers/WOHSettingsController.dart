// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/WOHRoutes.dart';

class WOHSettingsController extends GetxController {
  var currentIndex = 0.obs;
  final pages = <String>[WOHRoutes.SETTINGS_LANGUAGE, WOHRoutes.PROFILE, WOHRoutes.SETTINGS_THEME_MODE];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == WOHRoutes.PROFILE) {
      /*if (!Get.find<WOHAuthService>().isAuth) {
        currentIndex.value = 0;
        Get.find<WOHTabBarController>(tag: 'settings').selectedId.value = '0';
        //Get.toNamed(WOHRoutes.LOGIN);
      }*/
      return GetPageRoute(
        settings: settings,
        page: () => ProfileView(hideAppBar: true),
        binding: ProfileBinding(),
      );
    }
    /*if (settings.name == WOHRoutes.SETTINGS_ADDRESSES) {
      if (!Get.find<WOHAuthService>().isAuth) {
        currentIndex.value = 0;
        Get.find<WOHTabBarController>(tag: 'settings').selectedId.value = '0';
        Get.toNamed(WOHRoutes.LOGIN);
      }
      return GetPageRoute(
        settings: settings,
        page: () => AddressesView(hideAppBar: true),
        binding: SettingsBinding(),
      );
    }*/

    if (settings.name == WOHRoutes.SETTINGS_LANGUAGE)
      return GetPageRoute(
        settings: settings,
        page: () => LanguageView(hideAppBar: true),
        binding: SettingsBinding(),
      );

    if (settings.name == WOHRoutes.SETTINGS_THEME_MODE)
      return GetPageRoute(
        settings: settings,
        page: () => ThemeModeView(hideAppBar: true),
        binding: SettingsBinding(),
      );

    return null;
  }

  @override
  void onInit() {
    /*if (Get.isRegistered<WOHTabBarController>(tag: 'settings')) {
      Get.find<WOHTabBarController>(tag: 'settings').selectedId.value = '0';
    }*/
    currentIndex.value = 0;
    super.onInit();
  }
}