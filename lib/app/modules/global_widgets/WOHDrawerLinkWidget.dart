// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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
    Key key,
    this.icon,
    this.text,
    this.onTap,
    this.drawer,
    this.special,
  }) : super(key: key);

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
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            Expanded(
              child: Text(text.tr, style: Get.textTheme.bodyMedium.merge(TextStyle(fontSize: 14, color: !special ? buttonColor : specialColor))),
            ),
          ],
        ),
      ),
    );
  }
}