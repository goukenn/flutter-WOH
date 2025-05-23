// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHRatingController.dart';

class WOHRatingView extends GetView<WOHRatingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave a WOHReviewModel".tr,
          style: Get.textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: ListView(
        primary: true,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Column(
            children: [
              Wrap(children: [
                Text("Hi,".tr, style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.black))),
                Text(controller.shippingDto['partner_id'][1],
                  style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.black)),
                )
              ]),
              SizedBox(height: 10),
              Text(
                "How do you feel this services?".tr,
                style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.black)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: Get.width,
              decoration: WOHUi.getBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                  child: ClipOval(
                    child: FadeInImage(
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                      image: NetworkImage('${WOHConstants.serverPort}/image/res.partner/${controller.travellerId}/image_1920?unique=true&file_response=true',
                          headers: WOHConstants.getTokenHeaders()),
                      placeholder: AssetImage(
                          "assets/img/loading.gif"),
                      imageErrorBuilder:
                          (context, error, stackTrace) {
                        return Image.asset(
                            'assets/img/téléchargement (3).png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitWidth);
                      },
                    ),
                  )
                  ),
                  Text(controller.shippingDto['travel_partner_name'],
                    style: Get.textTheme.titleLarge!.merge(TextStyle(color: buttonColor)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Click on the stars to rate this traveller".tr,
                    style: Get.textTheme.labelSmall,
                  ),
                  SizedBox(height: 6),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return InkWell(
                          onTap: () {
                            controller.rate.value = (index + 1).toInt();
                          },
                          child: index < controller.rate.value
                              ? Icon(Icons.star, size: 40, color: Color(0xFFFFB24D))
                              : Icon(Icons.star_border, size: 40, color: Color(0xFFFFB24D)),
                        );
                      }),
                    );
                  }),
                  SizedBox(height: 30)
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: WOHTextFieldWidget(
              readOnly: false,
              labelText: "Write your review".tr,
              hintText: "Tell us somethings about this service".tr,
              iconData: Icons.description_outlined,
              onChanged: (text) {
                controller.comment.value = text;
              },
            )
          ),
          SizedBox(height: 20),
          WOHBlockButtonWidget(
              text: Obx(() => !controller.clicked.value ? Text(
                "Submit WOHReviewModel".tr,
                style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor)),
              ) : SizedBox(height: 30,
                  child: SpinKitThreeBounce(color: Colors.white, size: 20))
              ),
              onPressed: ()async {

                controller.clicked.value = true;
                await controller.rateTraveller(controller.shippingDto['id']);

              }).marginSymmetric(vertical: 10, horizontal: 20)
        ],
      ),
    );
  }
}