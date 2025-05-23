// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/controllers/WOHProfileController.dart';
import 'WOHBlockButtonWidget.dart';
import 'WOHTextFieldWidget.dart';

class WOHPhoneVerificationBottomSheetWidget extends GetView<WOHProfileController> {
  @override
  Widget build(BuildContext context) {
    // TODO add loading while verification
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.4).toInt()), blurRadius: 30, offset: Offset(0, -30)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: (Get.width / 2) - 30),
            decoration: BoxDecoration(
              color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.focusColor.withAlpha((255 * 0.5).toInt()),
                borderRadius: BorderRadius.circular(3),
              ),
              //child: SizedBox(height: 1,),
            ),
          ),
          Text(
            "We sent the OTP code to your phone, please check it and enter below".tr,
            style: Get.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 20, vertical: 10),
          WOHTextFieldWidget(
            labelText: "OTP Code".tr,
            hintText: "- - - - - -".tr,
            style: Get.textTheme.headlineMedium!.merge(TextStyle(letterSpacing: 8)),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (input) => controller.smsSent.value = input,
          ),
          WOHBlockButtonWidget(
            onPressed: () async {
              //await controller.verifyPhone();
            },
            text: Text(
              "Verify".tr,
              style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor)),
            ),
          ).paddingSymmetric(vertical: 30, horizontal: 20),
        ],
      ),
    );
  }
}