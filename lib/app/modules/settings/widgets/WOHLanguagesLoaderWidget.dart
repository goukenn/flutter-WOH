// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: WOHUi.getBoxDecoration(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withAlpha((255 * 0.1).toInt()),
        highlightColor: Colors.grey[200]!.withAlpha((255 * 0.1).toInt()),
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