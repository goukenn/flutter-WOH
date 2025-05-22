// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHAuthService.dart';
import '../../global_widgets/WOHTabBarWidget.dart';
import '../../profile/bindings/WOHProfileBinding.dart';
import '../../profile/views/WOHProfileView.dart';
import '../bindings/WOHSettingsBinding.dart';
import '../views/WOHAddressesView.dart';
import '../views/WOHLanguageView.dart';
import '../views/WOHThemeModeView.dart';

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
        Get.find<TabBarController>(tag: 'settings').selectedId.value = '0';
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
        Get.find<TabBarController>(tag: 'settings').selectedId.value = '0';
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
    /*if (Get.isRegistered<TabBarController>(tag: 'settings')) {
      Get.find<TabBarController>(tag: 'settings').selectedId.value = '0';
    }*/
    currentIndex.value = 0;
    super.onInit();
  }
}