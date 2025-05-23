// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WOHServicesEmptyListWidget extends StatelessWidget {
  const WOHServicesEmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(height: 60),
        Stack(
          children: <Widget>[
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                    Colors.grey.withAlpha((255 * 0.6).toInt()),
                    Colors.grey.withAlpha((255 * 0.2).toInt()),
                  ])),
              child: Icon(
                Icons.folder_special_outlined,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 70,
              ),
            ),
            Positioned(
              right: -30,
              bottom: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withAlpha((255 * 0.15).toInt()),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            ),
            Positioned(
              left: -20,
              top: -50,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withAlpha((255 * 0.15).toInt()),
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 40),
        Opacity(
          opacity: 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "You don't have any service inside this filter".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}