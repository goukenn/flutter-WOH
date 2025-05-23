// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WOHEProviderTitleBarWidget extends StatelessWidget implements PreferredSize {
  final Widget title;

  const WOHEProviderTitleBarWidget({super.key, required this.title});

  Widget buildTitleBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTitleBar();
  }

  @override
  Widget get child => buildTitleBar();

  @override
  Size get preferredSize => new Size(Get.width, 110);
}