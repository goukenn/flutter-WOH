// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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