// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repositories/WOHSettingRepository.dart';
import 'WOHSettingsService.dart';

class WOHTranslationService extends GetxService {
  final translations = Map<String, Map<String, String>>().obs;
  static List<String> languages = [];

  late WOHSettingRepository _settingsRepo;
  late GetStorage _box;

  WOHTranslationService() {
    _settingsRepo = new WOHSettingRepository();
    _box = new GetStorage();
  }

  // initialize the translation service by loading the assets/locales folder
  // the assets/locales folder must contains file for each language that named
  // with the code of language concatenate with the country code
  // for example (en_US.json)
  Future<WOHTranslationService> init() async {
    languages = await _settingsRepo.getSupportedLocales();
    await loadTranslation();
    return this;
  }

  Future<void> loadTranslation({locale}) async {
    locale = locale ?? getLocale().languageCode;
    Map<String, String> _translations = await _settingsRepo.getTranslations(locale);
    Get.addTranslations({locale: _translations});
  }

  Locale getLocale() {
    String _locale = _box.read<String>('language')!;
    if (_locale.isEmpty) {
      _locale = Get.find<WOHSettingsService>().setting.value.mobileLanguage!;
    }
    return fromStringToLocale(_locale);
  }

  // get list of supported local in the application
  List<Locale> supportedLocales() {
    print("result : $languages");
    return languages.map((_locale) {
      return fromStringToLocale(_locale);
    }).toList();
  }

  // Convert string code to local object
  Locale fromStringToLocale(String _locale) {

    if (_locale.contains('_')) {
      // en_US
      return Locale(_locale.split('_').elementAt(0), _locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(_locale);
    }
  }
}