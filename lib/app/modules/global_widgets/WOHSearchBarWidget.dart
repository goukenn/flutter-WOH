// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/controllers/WOHHomeController.dart';

class WOHSearchBarWidget extends StatelessWidget {
  final controller = Get.find<WOHHomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          border: Border.all(
            color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 0),
            child: Icon(Icons.search, color: Get.theme.colorScheme.secondary),
          ),
          Expanded(
            child: Text(
              "Search for handyman...".tr,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Get.textTheme.labelSmall,
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              //controller.increment();
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 6, bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    "Filter".tr,
                    style: TextStyle(color: Get.theme.hintColor),
                  ),
                  Icon(
                    Icons.filter_list,
                    color: Get.theme.hintColor,
                    size: 21,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}