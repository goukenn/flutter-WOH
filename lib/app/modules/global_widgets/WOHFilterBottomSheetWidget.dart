// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search/controllers/WOHSearchController.dart';
import 'WOHCircularLoadingWidget.dart';

class WOHFilterBottomSheetWidget extends GetView<WOHSearchController> {

  List transportMeans = [
    "Water",
    "Land",
    "Air"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height/2,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor
          .withAlpha(40)
          //.withAlpha((255 * 0.4).toInt())
          , blurRadius: 30, offset: Offset(0, -30)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 15, left: 4, right: 4),
              children: [
                Obx(() {
                  if (controller.categories.isEmpty) {
                    return WOHCircularLoadingWidget(height: 100);
                  }
                  return ExpansionTile(
                    title: Text("Travels".tr, style: Get.textTheme.bodyMedium),
                    children: List.generate(transportMeans.length, (index) {
                      var _category = transportMeans.elementAt(index);
                      return Obx(() {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: controller.selectedCategories.contains(_category),
                          onChanged: (value) {
                            //controller.toggleCategory(value, _category);
                          },
                          title: Text(
                            _category,
                            style: Get.textTheme.bodyLarge,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        );
                      });
                    }),
                    initiallyExpanded: true,
                  );
                }),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
            child: Row(
              children: [
                Expanded(child: Text("Filter".tr, style: Get.textTheme.headlineSmall)),
                MaterialButton(
                  onPressed: () {
                    controller.searchEServices(keywords: controller.textEditingController.text);
                    Get.back();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary.withAlpha(40),//.withAlpha((255 * 0.15).toInt()),
                  elevation: 0,
                  child: Text("Apply".tr, style: Get.textTheme.titleMedium!),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: (Get.width / 2) - 30),
            decoration: BoxDecoration(
              color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.focusColor.withAlpha((255 * 0.5).toInt()),
                borderRadius: BorderRadius.circular(3),
              ),
              //child: SizedBox(height: 1,),
            ),
          ),
        ],
      ),
    );
  }
}