// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../WOHColorConstants.dart' as WOHPalette;
import '../../../../common/animation_controllers/WOHDelayedAnimation.dart';
import '../controllers/WOHHomeController.dart';

class WOHFidelityCardView extends GetWidget<WOHHomeController> {
  @override
  Widget build(BuildContext context) {
    controller.timer = Timer.periodic(
      Duration(seconds: 3),
      (Timer timer) => controller.getUserDto(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {controller.timer.cancel(), Navigator.pop(context)},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Fidelity Card",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: WOHPalette.background,
          ),
        ),
      ),
      bottomSheet: Container(
        height: Get.height / 3,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: inactive.withAlpha((255 * 0.2).toInt()),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WOHDelayedAnimation(
                        delay: 1000,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 32.0,
                            left: 18,
                            right: 16,
                          ),
                          child: Obx(
                            () => RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "POINTS ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      color: Colors.grey.withAlpha(204),
                                      // .withAlpha((255 * 0.8).toInt()))
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\n ${controller.clientPoint.value}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      letterSpacing: 0.27,
                                      color: buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      WOHDelayedAnimation(
                        delay: 800,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 8,
                            top: 16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RatingBar(
                                initialRating:
                                    controller.clientPoint.value.toDouble() >
                                        controller.firstBar.value.toDouble()
                                    ? controller.firstBar.value.toDouble()
                                    : controller.clientPoint.value.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: controller.firstBar.value <= 5
                                    ? 5
                                    : controller.firstBar.value.toInt(),
                                itemSize: controller.firstBar.value <= 5
                                    ? 30
                                    : 15,
                                ratingWidget: RatingWidget(
                                  full: Icon(Icons.star, color: buttonColor),
                                  half: Icon(
                                    Icons.star_half,
                                    color: buttonColor,
                                  ),
                                  empty: Icon(Icons.star, color: inactive),
                                ),
                                itemPadding: EdgeInsets.zero,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              RatingBar(
                                initialRating:
                                    controller.clientPoint.value.toDouble() >
                                        controller.firstBar.value.toDouble()
                                    ? controller.clientPoint.value
                                              .toDouble() -
                                          controller.secondBar.value
                                              .toDouble()
                                    : controller.clientPoint.value
                                              .toDouble() -
                                          controller.firstBar.value
                                              .toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: controller.secondBar.value <= 5
                                    ? 5
                                    : controller.secondBar.value.toInt(),
                                itemSize: controller.secondBar.value <= 5
                                    ? 30
                                    : 15,
                                ratingWidget: RatingWidget(
                                  full: Icon(Icons.star, color: buttonColor),
                                  half: Icon(
                                    Icons.star_half,
                                    color: buttonColor,
                                  ),
                                  empty: Icon(Icons.star, color: inactive),
                                ),
                                itemPadding: EdgeInsets.zero,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.blue),
                  SizedBox(height: 10),
                  WOHDelayedAnimation(
                    delay: 600,
                    child: Text(
                      "BONUS",
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  WOHDelayedAnimation(
                    delay: 400,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Colors.red),
                      ),
                      child: Center(
                        child: Text(
                          controller.userBonus.value.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 0.5,
                            color: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: background,
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            WOHDelayedAnimation(
              delay: 600,
              child: Container(
                padding: EdgeInsets.only(
                  top: 00,
                  bottom: 20,
                  left: 60,
                  right: 60,
                ),
                margin: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: QrImageView(
                  // replace QrImage -> with QrImageView
                  data: controller.userId.value.toString(),
                  version: QrVersions.auto,
                  size: Get.width / 2,
                  gapless: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}