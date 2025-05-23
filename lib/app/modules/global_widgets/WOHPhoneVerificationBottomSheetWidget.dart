// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/controllers/WOHProfileController.dart';
import 'WOHBlockButtonWidget.dart';
import 'WOHTextFieldWidget.dart';

class WOHPhoneVerificationBottomSheetWidget extends GetView<ProfileController> {
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
          TextFieldWidget(
            labelText: "OTP Code".tr,
            hintText: "- - - - - -".tr,
            style: Get.textTheme.headline4!.merge(TextStyle(letterSpacing: 8)),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (input) => controller.smsSent.value = input,
          ),
          BlockButtonWidget(
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