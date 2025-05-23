// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHHelper.dart';
import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../../models/WOHSettingModel.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHSettingsService.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHAuthController.dart';

class WOHRegisterView extends GetView<WOHAuthController> {
  final WOHSettingModel _settings = Get.find<WOHSettingsService>().setting.value;
  String dropdownvalueGender = 'Select your gender'.tr;
  String dropdownvaluePiece = 'Select an identity piece'.tr;

  var selectedPiece = "Select an identity piece".obs;
  var selectedGender = "Select your gender".obs;


  var genderList = [
    'Select your gender'.tr,
    'Male'.tr,
    'Female'.tr,
  ];
  var identityPieceList = [
    'Select an identity piece'.tr,
    'CNI'.tr,
    'Passeport'.tr,
  ];

  var birthDay= DateTime.now().obs ;




  
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: WOHHelper().onWillPop,
      child: Scaffold(
        body: Form(
          key: WOHConstants.riKey1,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: Get.height/5,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/240_F_142999858_7EZ3JksoU3f4zly0MuY3uqoxhKdUwN5u.jpeg")),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "\nCréer un compte".tr,
                        style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    decoration: WOHUi.getBoxDecoration(
                      radius: 20,
                      border: Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/img/photo_2022-11-25_01-12-07.jpg',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                 return Container(
                   padding: EdgeInsets.symmetric(horizontal: 10),
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        WOHTextFieldWidget(
                          labelText: "Nom".tr,
                          hintText: "John Doe".tr,
                          readOnly: false,
                          initialValue: controller.name.value,
                          onSaved: (input) => controller.name.value = input!,
                          onChanged: (input) => controller.name.value = input ,
                          validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                          iconData: Icons.person_outline,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                          margin: EdgeInsets.only(left: 5, right: 5, bottom: 10 ),
                          decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, 5)),
                              ],
                              border: Border.all(color: Get.theme.focusColor.withAlpha((255 * 0.05).toInt()))),
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              hintText: '032655333333',
                              label: Text("Contact"),
                              suffixIcon: Icon(Icons.phone_android_outlined),
                            ),
                            style: TextStyle( color: Colors.black),
                            initialCountryCode: 'BE',
                            onChanged: (phone) {
                              String phoneNumber = phone.completeNumber;
                              controller.phone.value = phoneNumber;
                            },
                          ),
                        ),
                        WOHTextFieldWidget(
                          labelText: "Adresse mail".tr,
                          hintText: "johndoe@gmail.com".tr,
                          readOnly: false,
                          initialValue: controller.email.value,
                          onChanged: (value) => controller.email.value = value,
                          onSaved: (input) => controller.email.value = input!,
                          validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                          iconData: Icons.alternate_email,
                        ),

                        Obx(() {
                          return WOHTextFieldWidget(
                            onChanged: (newValue){
                              controller.password.value = newValue;
                            },
                            labelText: "Password".tr,
                            hintText: "••••••••••••".tr,
                            readOnly: false,
                            initialValue: controller.password.value,
                            onSaved: (input) => controller.password.value = input!,
                            validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                            obscureText: controller.hidePassword.value,
                            iconData: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.hidePassword.value = !controller.hidePassword.value;
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            ),
                          );
                        }),

                        Obx(() {
                          return WOHTextFieldWidget(
                            onChanged: (newValue){
                              if(newValue!=controller.password.value){

                                controller.confirmPassword.value = 'password not matching';
                              }
                              else{
                                controller.confirmPassword.value = controller.password.value;
                              }
                            },
                            labelText: "Confirm Password".tr,
                            errorText: (controller.confirmPassword.value == 'password not matching'?'password not matching':''),
                            hintText: "••••••••••••".tr,
                            readOnly: false,
                            obscureText: controller.hidePassword.value,
                            iconData: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            isLast: true,
                            isFirst: false,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.hidePassword.value = !controller.hidePassword.value;
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            ),
                          );
                        }),
                        Obx(() =>
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: controller.accepted.value,
                                  onChanged: (value){
                                    controller.accepted.value = value!;
                                    print(controller.accepted.value);
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(WOHRoutes.POLITIQUE);
                                  }, // Disable button if not checked
                                  child: Text('Politique de confidentalité',
                                    style: TextStyle(decoration: TextDecoration.underline,
                                        color: primaryColor)),
                                ),
                              ],
                            ),
                        )
                      ],
                    ),
                 );
                }
              )
            ],
          ),
        ),

        bottomNavigationBar: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: Get.width,
                  child: WOHBlockButtonWidget(
                    disabled: !controller.accepted.value,
                    color: controller.accepted.value ? interfaceColor : interfaceColor.withAlpha((255 * 0.3).toInt()),
                    onPressed: controller.accepted.value ? () async{

                      if(WOHConstants.riKey1.currentState!.validate()){
                        if(controller.password.value == controller.confirmPassword.value)
                        {
                          await controller.register();
                        }
                      }

                    } : null,
                    text: !controller.loading.value?Text(
                      "SOUMETRE".tr,
                      style: Get.textTheme.headlineMedium!.merge(TextStyle(color: Get.theme.primaryColor)),
                    ): SizedBox(height: 20,
                        child: SpinKitFadingCircle(color: Colors.white, size: 30)), loginPage: false,
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Vous avez déjà un compte?".tr, style: Get.textTheme.headlineMedium),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(WOHRoutes.LOGIN);
                      },
                      child: Text("connexion",style: TextStyle(fontFamily: "poppins",fontSize: 15, color: Colors.blueAccent)),
                    ),

                  ],).paddingOnly(bottom: 10)


              ],
            ),
          ],
        ),)

      ),
    );
  }
}