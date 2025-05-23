// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/WOHSettingsService.dart';
import '../../../services/translation_service.dart';
import 'WOHThemeModeController.dart';

class WOHLanguageController extends GetxController {
  GetStorage _box;

  WOHLanguageController() {
    _box = new GetStorage();
  }

  /*void updateLocale(value) async {
    await Get.find<TranslationService>().loadTranslation(locale: value);
    if (value.contains('_')) {
      // en_US
      Get.updateLocale(Locale(value.split('_').elementAt(0), value.split('_').elementAt(1)));
    } else {
      // en
      Get.updateLocale(Locale(value));
    }
    await _box.write('language', value);
    if (Get.isDarkMode) {
      Get.find<ThemeModeController>().changeThemeMode(ThemeMode.light);
    }
    Get.rootController.setTheme(Get.find<WOHSettingsService>().getLightTheme());
  }*/
}