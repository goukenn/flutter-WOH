// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WOHThemeModeController extends GetxController {
  final selectedThemeMode = ThemeMode.light.obs;
  late GetStorage _box;

  WOHThemeModeController() {
    _box = new GetStorage();
  }

  @override
  void onInit() {
    initThemeMode();
    super.onInit();
  }

  void initThemeMode() {
    String _themeMode = _box.read<String>('theme_mode')!;
    switch (_themeMode) {
      case 'ThemeMode.light':
        selectedThemeMode.value = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        selectedThemeMode.value = ThemeMode.dark;
        break;
      case 'ThemeMode.system':
        selectedThemeMode.value = ThemeMode.system;
        break;
      default:
        selectedThemeMode.value = ThemeMode.system;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    selectedThemeMode.value = themeMode;
    if (themeMode == ThemeMode.dark) {
      //Get.rootController.setTheme(Get.find<WOHSettingsService>().getDarkTheme());
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
      );
    } else {
      //Get.rootController.setTheme(Get.find<WOHSettingsService>().getLightTheme());
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
      );
    }
    _box.write('theme_mode', themeMode.toString());
    Get.rootController.refresh();
  }
}