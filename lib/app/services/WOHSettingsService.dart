// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../WOHColorConstants.dart';
import '../../common/WOHUi.dart';
import '../models/WOHAddressModel.dart';
import '../models/WOHSettingModel.dart';
import '../repositories/WOHSettingRepository.dart';
import 'WOHAuthService.dart';

class WOHSettingsService extends GetxService {
  final setting = WOHSettingModel().obs;
  final address = WOHAddressModel().obs;
  late GetStorage _box;
  late WOHSettingRepository _settingsRepo;

  WOHSettingsService() {
    _settingsRepo = new WOHSettingRepository();
    _box = new GetStorage();
  }

  Future<WOHSettingsService> init() async {
    address.listen((WOHAddressModel _address) {
      _box.write('current_address', _address.toJson());
    });
    //setting.value = await _settingsRepo.get();
    //setting.value.modules = await _settingsRepo.getModules();
    await getAddress();
    return this;
  }

  ThemeData getLightTheme() {
    return ThemeData(
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: WOHUi.parseColor(setting.value.accentColor!, opacity: 0.1),
        focusColor: inactive,
        //WOHUi.parseColor(setting.value.accentColor),
        hintColor: WOHUi.parseColor(setting.value.secondColor!),
        textButtonTheme: TextButtonThemeData(
          // + | change from color 
          // style: TextButton.styleFrom(primary: WOHUi.parseColor(setting.value.mainColor)),
          style: TextButton.styleFrom(foregroundColor: WOHUi.parseColor(setting.value.mainColor!)),
        ),
        colorScheme: ColorScheme.light(
          primary: pink,
          secondary: interfaceColor,
        ),
        textTheme: GoogleFonts.getTextTheme(
          'Poppins',
          TextTheme(
            // + ||| /// @TODO
            // titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
            // headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
            // headline4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: buttonColor, height: 1.3),
            // headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
            // headline2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: buttonColor, height: 1.4),
            // headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: interfaceColor, height: 1.4),
            // bodySmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: interfaceColor, height: 1.2),
            // subtitle1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: pink, height: 1.2),
            // bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: interfaceColor, height: 1.2),
            // bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: interfaceColor, height: 1.2),
            // caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: WOHUi.parseColor(setting.value.accentColor), height: 1.2),
          ),

        ));
  }

  ThemeData getDarkTheme() {
    return ThemeData(
        primaryColor: Color(0xFF252525),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        dividerColor: WOHUi.parseColor(setting.value.accentDarkColor!, opacity: 0.1),
        focusColor: WOHUi.parseColor(setting.value.accentDarkColor!),
        hintColor: WOHUi.parseColor(setting.value.secondDarkColor!),
        // checkboxTheme: CheckboxThemeData(
        //   fillColor: WidgetStateProperty(WOHUi.parseColor(setting.value.mainDarkColor!))
        // ),
        //  radioTheme: RadioThemeData(
        //   fillColor: WOHUi.parseColor(setting.value.mainDarkColor!)
        // ),
        // toggleableActiveColor: WOHUi.parseColor(setting.value.mainDarkColor!),
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(primary: WOHUi.parseColor(setting.value.mainColor!)),
        // ),
        colorScheme: ColorScheme.dark(
          primary: pink,
          secondary: interfaceColor,
        ),
        textTheme: GoogleFonts.getTextTheme(
            'Poppins',
            TextTheme(
              // titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
              // headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
              // headline4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: buttonColor, height: 1.3),
              // headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: interfaceColor, height: 1.3),
              // headline2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: buttonColor, height: 1.4),
              // headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: interfaceColor, height: 1.4),
              // bodySmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: interfaceColor, height: 1.2),
              // subtitle1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: pink, height: 1.2),
              // bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: interfaceColor, height: 1.2),
              // bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: interfaceColor, height: 1.2),
              // caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: WOHUi.parseColor(setting.value.accentDarkColor), height: 1.2),
            )));
  }

  /*String? _getLocale() {
    String? _locale = GetStorage().read<String>('language');
    if (_locale == null || _locale.isEmpty) {
      _locale = setting.value.mobileLanguage;
    }
    return _locale;
  }*/

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (setting.value.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
          );
          return ThemeMode.light;
        }
    }
  }

  Future getAddress() async {
    try {
      if (_box.hasData('current_address') && !address.value.isUnknown()) {
        address.value = WOHAddressModel.fromJson(await _box.read('current_address'));
      } else if (Get.find<WOHAuthService>().isAuth!) {
        List<WOHAddressModel> _addresses = await _settingsRepo.getAddresses();
        if (_addresses.isNotEmpty) {
          address.value = _addresses.firstWhere((_address) => _address.isDefault!, orElse: () {
            return _addresses.first;
          });
        }
      }
    } catch (e) {
      Get.log(e.toString());
    }
  }
}