// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';

import '../../../../common/WOHUi.dart';

class WOHEServiceTilWidget extends StatelessWidget {
  final Widget title;
  final Widget title2;
  final Widget content;
  final List<Widget> actions;
  final double horizontalPadding;

  const WOHEServiceTilWidget({Key key, this.title2, this.title, this.content, this.actions, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10, vertical: 15),
      decoration: WOHUi.getBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              title,
              Spacer(),
              title2
            ],
          ),
          Divider(
            height: 26,
            thickness: 1.2,
          ),
          content,
        ],
      ),
    );
  }
}