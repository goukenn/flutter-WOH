// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../providers/laravel_provider.dart';
import '../../../services/translation_service.dart';
import '../controllers/WOHLanguageController.dart';
import '../widgets/WOHLanguagesLoaderWidget.dart';

class WOHLanguageView extends GetView<LanguageController> {
  final bool hideAppBar;

  WOHLanguageView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Languages".tr,
                  style: context.textTheme.titleLarge,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        body: ListView(
          primary: true,
          children: [
            Obx(() {
              if (Get.find<LaravelApiClient>().isLoading(task: 'getTranslations')) {
                return LanguagesLoaderWidget();
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: WOHUi.getBoxDecoration(),
                child: Column(
                  children: List.generate(TranslationService.languages.length, (index) {
                    var _lang = TranslationService.languages.elementAt(index);
                    return RadioListTile(
                      value: _lang,
                      groupValue: Get.locale.toString(),
                      activeColor: Get.theme.colorScheme.secondary,
                      onChanged: (value) {
                        //controller.updateLocale(value);
                      },
                      title: Text(_lang.tr, style: Get.textTheme.bodyText2),
                    );
                  }).toList(),
                ),
              );
            })
          ],
        ));
  }
}