// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * File name: WOHLanguagesLoaderWidget.dart
 * Last modified: 2022.03.10 at 21:33:46
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/WOHUi.dart';

class WOHLanguagesLoaderWidget extends StatelessWidget {
  const WOHLanguagesLoaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: WOHUi.getBoxDecoration(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withAlpha((255 * 0.1).toInt()),
        highlightColor: Colors.grey[200].withAlpha((255 * 0.1).toInt()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            5,
            (index) => Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ).marginSymmetric(vertical: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}