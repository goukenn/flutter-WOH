// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart'; 
import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../../models/WOHMyUserModel.dart';
import '../../../models/WOHSettingModel.dart';
import '../../../repositories/WOHUserRepository.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../../services/WOHSettingsService.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHAuthController.dart';

class WOHVerificationView extends GetView<WOHAuthController> {
  final WOHSettingModel _settings = Get.find<WOHSettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    final Rx<WOHMyUserModel> currentUser = Get.find<WOHMyAuthService>().myUser;
    WOHUserRepository _userRepository;

    _userRepository = WOHUserRepository();
    Get.put(currentUser);

    return PopScope( // ) /*WillPopScope*/ PopScope(
     // onWillPop: WOHHelper().onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Double Verification".tr,
              style: Get.textTheme.titleLarge!.merge(TextStyle(color: context.theme.primaryColor)),
            ),
            centerTitle: true,
            backgroundColor: Get.theme.colorScheme.secondary,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
              onPressed: () => {Get.back()},
            ),
          ),
          body: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 140,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("",
                            style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Welcome to the best service provider system!".tr,
                            style: Get.textTheme.labelSmall!.merge(TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.labelSmall!.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: WOHUi.getBoxDecoration(
                      radius: 14,
                      border: Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/icon/icon.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return WOHCircularLoadingWidget(height: 300, onComplete: (void value) {  }, onCompleteText: '',);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      RichText(
                        text: TextSpan(
                          text: "Please enter the code sent to ",
                          children: [
                            TextSpan(
                              text: controller.email.value,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 20, vertical: 20),

                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        child: WOHTextFieldWidget(
                          labelText: "Verification Code".tr,
                          hintText: "- - - - - -".tr,
                          style: Get.textTheme.headlineMedium!.merge(TextStyle(letterSpacing: 8)),
                          textAlign: TextAlign.center,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          onChanged: (input) => controller.smsSent.value = input,
                          iconData: Icons.add_to_home_screen_outlined,
                        ),
                      ),

                      WOHBlockButtonWidget(
                        onPressed: () async {
                          //await controller.verifyPhone();
                          controller.verifyClicked.value = true;
                          if(controller.code.value == controller.smsSent.value){

                            var foundDeviceToken= false;

                            if(Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds.isNotEmpty)
                            {
                              for(int i = 0; i<Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds.length;i++){
                                if(WOHConstants.deviceToken == Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds[i]){
                                  foundDeviceToken = true;
                                }
                              }
                            }
                            /*
                            if(!foundDeviceToken){
                              await controller.saveDeviceToken(WOHConstants.deviceToken, Get.find<WOHMyAuthService>().myUser.value.id);
                            }*/
                            controller.verifyClicked.value = false;

                          }else{

                            Get.showSnackbar(WOHUi.ErrorSnackBar(message: "Verification code not valid, please try again!"));

                          }
                        },
                        text: !controller.verifyClicked.value ? Text(
                          "Verify".tr,
                          style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor)),
                        ): SizedBox(height: 30,
                            child: SpinKitThreeBounce(color: Colors.white, size: 20)),
                      ).paddingSymmetric(vertical: 30, horizontal: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              //controller.resendOTPCode();
                            },
                            child: Text("Resend the OTP Code Again".tr, style: TextStyle(
                              color: interfaceColor,
                              fontSize: 12,
                            ),),
                          ),
                        ],
                      )
                    ],
                  );
                }
              })
            ],
          )),
    );
  }
}