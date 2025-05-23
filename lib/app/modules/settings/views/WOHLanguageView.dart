// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../../services/WOHTranslationService.dart'; 
import '../controllers/WOHLanguageController.dart';
import '../widgets/WOHLanguagesLoaderWidget.dart';

class WOHLanguageView extends GetView<WOHLanguageController> {
  final bool hideAppBar;

  WOHLanguageView({super.key, this.hideAppBar = false});

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
              if (Get.find<WOHLaravelApiClientProvider>().isLoading(task: 'getTranslations', tasks: [])) {
                return WOHLanguagesLoaderWidget();
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: WOHUi.getBoxDecoration(),
                child: Column(
                  children: List.generate(WOHTranslationService.languages.length, (index) {
                    var _lang = WOHTranslationService.languages.elementAt(index);
                    return RadioListTile(
                      value: _lang,
                      groupValue: Get.locale.toString(),
                      activeColor: Get.theme.colorScheme.secondary,
                      onChanged: (value) {
                        //controller.updateLocale(value);
                      },
                      title: Text(_lang.tr, style: Get.textTheme.bodyMedium),
                    );
                  }).toList(),
                ),
              );
            })
          ],
        ));
  }
}