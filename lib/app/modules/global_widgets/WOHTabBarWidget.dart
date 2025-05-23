// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WOHTabBarController extends GetxController {
  RxString selectedId;

  @override
  void onInit() {
    super.onInit();
  }

  WOHTabBarController() {
    selectedId = RxString("");
  }

  bool isSelected(dynamic tabId) => selectedId.value == tabId.toString();

  void toggleSelected(
    dynamic tabId,
  ) {
    if (!isSelected(tabId)) {
      selectedId.value = tabId.toString();
    }
  }
}

class WOHTabBarWidget extends StatelessWidget implements PreferredSize {
  WOHTabBarWidget({super.key, required this.tag, required this.tabs, required this.initialSelectedId}) {
    tabs[0] = Padding(padding: EdgeInsetsDirectional.only(start: 15), child: tabs.elementAt(0));
    tabs[tabs.length - 1] = Padding(padding: EdgeInsetsDirectional.only(end: 15), child: tabs[tabs.length - 1]);
  }

  final String tag;
  final dynamic initialSelectedId;
  final List<Widget> tabs;

  Widget buildTabBar() {
    final controller = Get.put(WOHTabBarController(), tag: tag, permanent: true);
    if (controller.selectedId.firstRebuild) {
      controller.selectedId.value = initialSelectedId.toString();
    }
    return Container(
      alignment: AlignmentDirectional.centerStart,
      height: 60,
      child: ListView(primary: false, shrinkWrap: true, scrollDirection: Axis.horizontal, children: tabs),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTabBar();
  }

  @override
  Widget get child => buildTabBar();

  @override
  Size get preferredSize => new Size(Get.width, 60);
}

class WOHTabBarLoadingWidget extends StatelessWidget implements PreferredSize {
  Widget buildTabBar() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      height: 60,
      child: ListView(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          3,
          (index) => RawChip(
            elevation: 0,
            label: Text(''),
            padding: EdgeInsets.symmetric(horizontal: 20.0 * (index + 1), vertical: 15),
            backgroundColor: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
            selectedColor: Get.theme.colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            showCheckmark: false,
            pressElevation: 0,
          ).marginSymmetric(horizontal: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTabBar();
  }

  @override
  Widget get child => buildTabBar();

  @override
  Size get preferredSize => new Size(Get.width, 60);
}