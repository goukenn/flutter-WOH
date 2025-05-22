// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../color_constants.dart';
import '../../../../common/WOHHelper.dart';
import '../../../../common/ui.dart';
import '../../../../main.dart';
import '../../../models/WOHMyUserModel.dart';
import '../../../models/WOHSettingModel.dart';
import '../../../repositories/WOHWHOUserRepository.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHAuthController.dart';

class VerificationView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    final Rx<MyUser> currentUser = Get.find<MyAuthService>().myUser;
    WOHWHOUserRepository _userRepository;

    _userRepository = WOHWHOUserRepository();
    Get.put(currentUser);

    return WillPopScope(
      onWillPop: WOHHelper().onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Double Verification".tr,
              style: Get.textTheme.titleLarge.merge(TextStyle(color: context.theme.primaryColor)),
            ),
            centerTitle: true,
            backgroundColor: Get.theme.colorScheme.secondary,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
              onPressed: () async{
              await Get.find<MyAuthService>().removeCurrentUser();

              Get.toNamed(WOHRoutes.LOGIN);
              },
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
                        BoxShadow(color: Get.theme.focusColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("",
                            style: Get.textTheme.titleLarge.merge(TextStyle(color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Welcome to the best service provider system!".tr,
                            style: Get.textTheme.labelSmall.merge(TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.labelSmall.merge(TextStyle(color: Get.theme.primaryColor))),
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
                    ),),
                ],
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
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
                        child: TextFieldWidget(
                          labelText: "Verification Code".tr,
                          hintText: "- - - - - -".tr,
                          style: Get.textTheme.headline4.merge(TextStyle(letterSpacing: 8)),
                          textAlign: TextAlign.center,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          onChanged: (input) => controller.smsSent.value = input,
                          // iconData: Icons.add_to_home_screen_outlined,
                        ),
                      ),

                      BlockButtonWidget(
                        onPressed: () async {
                          //await controller.verifyPhone();
                          /*
                          if(controller.smsSent.value.isNotEmpty){
                            controller.verifyClicked.value = true;

                            Get.find<MyAuthService>().myUser.value = await _userRepository.get(controller.authUserId.value);
                            if(Get.find<MyAuthService>().myUser.value.id != null){
                              var foundDeviceToken= false;

                              if(Get.find<MyAuthService>().myUser.value.deviceTokenIds.isNotEmpty)
                              {
                                for(int i = 0; i<Get.find<MyAuthService>().myUser.value.deviceTokenIds.length;i++){
                                  if(Domain.deviceToken==Get.find<MyAuthService>().myUser.value.deviceTokenIds[i]){
                                    foundDeviceToken = true;
                                  }
                                }

                              }
                              else{
                                await controller.saveDeviceToken(Domain.deviceToken, Get.find<MyAuthService>().myUser.value.id);
                              }

                              if(!foundDeviceToken){
                                await controller.saveDeviceToken(Domain.deviceToken, Get.find<MyAuthService>().myUser.value.id);
                              }
                              controller.loading.value = false;
                              Get.showSnackbar(WOHUi.SuccessSnackBar(message: "You logged in successfully " ));

                              controller.verifyClicked.value = false;

                              await Get.toNamed(WOHRoutes.ROOT);
                            }
                            else{
                              controller.loading.value = false;
                            }
                          }*/
                        },
                        text: !controller.verifyClicked.value ? Text(
                          "Verify".tr,
                          style: Get.textTheme.titleLarge.merge(TextStyle(color: Get.theme.primaryColor)),
                        ): SizedBox(height: 30,
                            child: SpinKitThreeBounce(color: Colors.white, size: 20)), loginPage: false,
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