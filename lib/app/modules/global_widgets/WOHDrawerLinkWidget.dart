// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';

class WOHDrawerLinkWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool special;
  final bool drawer;
  final ValueChanged<void> onTap;
  const WOHDrawerLinkWidget({
    super.key,
    this.icon,
    this.text,
    this.onTap,
    this.drawer,
    this.special,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap('');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            drawer ?
            Icon(
              icon,
              color: !special ? buttonColor : specialColor, size: 22,
            ) : Icon(
              icon,
              color: !special ? buttonColor : specialColor,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: 1,
              height: 24,
              color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
            ),
            Expanded(
              child: Text(text.tr, style: Get.textTheme.bodyMedium!.merge(TextStyle(fontSize: 14, color: !special ? buttonColor : specialColor))),
            ),
          ],
        ),
      ),
    );
  }
}