// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'WOHTabBarWidget.dart';

class WOHChipWidget extends StatelessWidget {
  WOHChipWidget({
    super.key,
    required this.text,
    this.onSelected,
    required this.tag,
    required this.id,
  });

  final String text;
  final dynamic id;
  final String tag;
  final ValueChanged<dynamic>? onSelected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WOHTabBarController(), tag: tag, permanent: true);
    return Obx(() {
      return RawChip(
        elevation: 0,
        label: Text(text),
        labelStyle: controller.isSelected(this.id) ? Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor)) : Get.textTheme.bodyMedium,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        backgroundColor: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
        selectedColor: Get.theme.colorScheme.secondary,
        selected: controller.isSelected(this.id),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        showCheckmark: false,
        pressElevation: 0,
        onSelected: (bool value) {
          controller.toggleSelected(this.id);
          onSelected!(id);
        },
      ).marginSymmetric(horizontal: 5);
    });
  }
}