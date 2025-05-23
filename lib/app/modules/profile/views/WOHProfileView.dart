// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:com_igkdev_new_app/WOHConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../WOHColorConstants.dart';
import '../../global_widgets/WOHPhoneFieldWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHProfileController.dart';
import '../widgets/WOHDeleteAccountWidget.dart';
import '../widgets/WOHUpdatePasswordWidget.dart';

class WOHProfileView extends GetView<WOHProfileController> {
  final bool hideAppBar;

  WOHProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    //controller.profileForm = new GlobalKey<FormState>();
    return Scaffold(
      appBar: hideAppBar
          ? null
          : AppBar(
              title: Text("Profile".tr, style: context.textTheme.titleLarge),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back_ios,
                  color: Get.theme.hintColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0,
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Obx(
          () => MaterialButton(
            onPressed: () {
              if (!controller.birthDateSet.value) {
                controller.user.value.birthday = DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(controller.user.value.birthday!))
                    .toString();
                //controller.birthDateSet.value = true;
              }
              if (controller.birthDate.value.toString().contains('-')) {
                controller.user.value.birthday = controller.birthDate.value;
              }
              controller.saveProfileForm();
              controller.buttonPressed.value = !controller.buttonPressed.value;
            },
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Get.theme.colorScheme.secondary,
            child: !controller.buttonPressed.value
                ? Text(
                    "Update".tr,
                    style: Get.textTheme.bodyMedium!.merge(
                      TextStyle(color: Get.theme.primaryColor),
                    ),
                  )
                : SizedBox(
                    height: 10,
                    child: SpinKitThreeBounce(color: Colors.white, size: 20),
                  ),
            elevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
          ),
        ).paddingSymmetric(vertical: 10, horizontal: 20),
      ),
      body: Form(
        key: controller.profileForm,
        child: ListView(
          primary: true,
          children: [
            Obx(() {
              return Column(
                children: [
                  Text(
                    "Change the following details and save them".tr,
                    style: Get.textTheme.labelSmall,
                  ).paddingSymmetric(horizontal: 22, vertical: 5),
                  WOHTextFieldWidget(
                    onChanged: (input) => controller.user.value.name = input,
                    onSaved: (input) => controller.user.value.name = input,
                    validator: (input) => (null != input) && (input.length < 3)
                        ? "Should be more than 3 letters".tr
                        : null,
                    hintText: "John Doe".tr,
                    labelText: "Full Name".tr,
                    iconData: Icons.person_outline,
                    initialValue: controller.user.value.name!,
                  ),
                  WOHTextFieldWidget(
                    validator: (input) =>
                        !input!.contains('@') ? "Should be a valid email" : null,
                    hintText: "johndoe@gmail.com",
                    onChanged: (input) => controller.user.value.email = input,
                    onSaved: (input) => controller.user.value.email = input,
                    labelText: "Email".tr,
                    iconData: Icons.alternate_email,
                    initialValue: controller.user.value.email!,
                  ),

                  //Obx(() {
                  controller.editNumber.value == false
                      ? InkWell(
                          onTap: () => {controller.editNumber.value == true},
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 20,
                              right: 20,
                            ),
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Get.theme.focusColor.withAlpha(
                                    (255 * 0.1).toInt(),
                                  ),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: Get.theme.focusColor.withAlpha(
                                  (255 * 0.05).toInt(),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //Text(controller.currentUser.value.phone,style: Get.textTheme.bodyLarge,),
                                Obx(
                                  () => ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.phone,
                                      size: 20,
                                    ),
                                    title: Text(
                                      controller.user.value.phone!,
                                      style: Get.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),

                                // Text('Edit...',style: Get.textTheme.bodyLarge,),
                                TextButton(
                                  onPressed: (() {
                                    controller.editNumber.value = true;
                                  }),
                                  child: Text(
                                    'Edit...',
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WOHPhoneFieldWidget(
                              labelText: "Phone Number".tr,
                              hintText: WOHConstants.hintPhoneContact,
                              //initialValue: controller.currentUser.value.phone,
                              onSaved: (phone) {
                                controller.user.value.phone = phone!.completeNumber;
                              },
                              onChanged: (input) =>
                                  controller.user.value.phone = input
                                      .toString(),
                            ),
                            TextButton(
                              onPressed: (() {
                                controller.editNumber.value = false;
                              }),
                              child: Text(
                                'Cancel...',
                                style: Get.textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),

                  InkWell(
                    onTap: () {
                      controller.chooseBirthDate();
                      //controller.user.value.birthday = DateFormat('yy/MM/dd').format(controller.birthDate.value);
                      controller.birthDateSet.value = true;
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      margin: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Get.theme.focusColor.withAlpha(
                              (255 * 0.1).toInt(),
                            ),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: Get.theme.focusColor.withAlpha(
                            (255 * 0.05).toInt(),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Date of birth".tr,
                            style: Get.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                          Obx(() {
                            return ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.cakeCandles,
                                size: 20,
                              ),
                              title: Text(
                                controller.birthDate.value.toString(),
                                style: Get.textTheme.bodyLarge,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  // }
                  //
                  // ),
                  // WOHTextFieldWidget(
                  //   onChanged: (input) => controller.user.value.birthplace = input,
                  //   onSaved: (input) => controller.user.value.birthplace = input,
                  //   validator: (input) => input.length < 3 ? "Should be more than 3 letters".tr : null,
                  //   hintText: "123 Street, City 136, State, Country".tr,
                  //   labelText: "Place of birth".tr,
                  //   iconData: Icons.location_on_rounded,
                  //   initialValue: controller.user.value.birthplace,
                  // ),
                  //
                  // WOHTextFieldWidget(
                  //   onChanged: (input) => controller.user.value.street = input,
                  //   onSaved: (input) => controller.user.value.street = input,
                  //   validator: (input) => input.length < 3 ? "Should be more than 3 letters".tr : null,
                  //   hintText: "123 Street, City 136, State, Country".tr,
                  //   labelText: "WOHAddressModel".tr,
                  //   iconData: Icons.location_on_rounded,
                  //   initialValue: controller.user.value.street,
                  // ),
                  //
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      bottom: 10,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.focusColor.withAlpha(
                            (255 * 0.1).toInt(),
                          ),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Get.theme.focusColor.withAlpha(
                          (255 * 0.05).toInt(),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Place of Birth",
                          style: Get.textTheme.bodyLarge,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                controller: controller.depTown,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 15,
                                    bottom: 11,
                                    top: 11,
                                    right: 15,
                                  ),
                                ),
                                //initialValue: controller.travelCard.isEmpty || controller.townEdit.value ? controller.departureTown.value : controller.travelCard['departure_town'],
                                style: Get.textTheme.displayLarge!.merge(
                                  TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                onChanged: (value) => {
                                  if (value.length > 2)
                                    {
                                      controller.predict1.value = true,
                                      controller.filterSearchResults(value),
                                    }
                                  else
                                    {controller.predict1.value = false},
                                },
                                cursorColor: Get.theme.focusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (controller.predict1.value)
                    Obx(
                      () => Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                        color: Get.theme.primaryColor,
                        height: 200,
                        child: ListView(
                          children: [
                            for (
                              var i = 0;
                              i < controller.countries.length;
                              i++
                            ) ...[
                              TextButton(
                                onPressed: () {
                                  controller.depTown.text =
                                      '${controller.countries[i]['display_name']}, (${controller.countries[i]['country_id'][1]})';
                                  controller.predict1.value = false;
                                  controller.departureId.value =
                                      controller.countries[i]['id'];
                                  controller.user.value.birthplace = controller
                                      .countries[i]['id']
                                      .toString();
                                },
                                child: Text(
                                  '${controller.countries[i]['display_name']}, (${controller.countries[i]['country_id'][1]})\n',
                                  style: TextStyle(color: appColor),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      bottom: 10,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.focusColor.withAlpha(
                            (255 * 0.1).toInt(),
                          ),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Get.theme.focusColor.withAlpha(
                          (255 * 0.05).toInt(),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Residential WOHAddressModel",
                          style: Get.textTheme.bodyLarge,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextFormField(
                                controller: controller.arrTown,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 15,
                                    bottom: 11,
                                    top: 11,
                                    right: 15,
                                  ),
                                ),
                                //initialValue: controller.travelCard.isEmpty || controller.townEdit.value ? controller.departureTown.value : controller.travelCard['departure_town'],
                                style: Get.textTheme.displayLarge!.merge(
                                  TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                onChanged: (value) => {
                                  if (value.length > 2)
                                    {
                                      controller.predict2.value = true,
                                      controller.filterSearchResults(value),
                                    }
                                  else
                                    {controller.predict2.value = false},
                                },
                                cursorColor: Get.theme.focusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (controller.predict2.value)
                    Obx(
                      () => Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                        color: Get.theme.primaryColor,
                        height: 200,
                        child: ListView(
                          children: [
                            for (
                              var i = 0;
                              i < controller.countries.length;
                              i++
                            ) ...[
                              TextButton(
                                onPressed: () {
                                  controller.arrTown.text =
                                      '${controller.countries[i]['display_name']}, (${controller.countries[i]['country_id'][1]})';
                                  controller.predict2.value = false;
                                  controller.arrivalId.value =
                                      controller.countries[i]['id'];
                                  controller.user.value.street = controller
                                      .countries[i]['id']
                                      .toString();
                                },
                                child: Text(
                                  '${controller.countries[i]['display_name']}, (${controller.countries[i]['country_id'][1]})\n',
                                  style: TextStyle(color: appColor),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  Container(
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.focusColor.withAlpha(
                            (255 * 0.1).toInt(),
                          ),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Get.theme.focusColor.withAlpha(
                          (255 * 0.05).toInt(),
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child:
                          DropdownButtonFormField(
                                decoration: InputDecoration.collapsed(
                                  hintText: '',
                                ),
                                onSaved: (input) =>
                                    controller.selectedGender.value == "Male"
                                    ? controller.user.value.sex = "M"
                                    : controller.user.value.sex = "F",
                                isExpanded: true,
                                alignment: Alignment.bottomCenter,

                                style: Get.textTheme.bodyLarge,
                                value: controller.user.value.sex == "male"
                                    ? controller.selectedGender.value =
                                          controller.genderList[0]
                                    : controller.selectedGender.value =
                                          controller.genderList[1],
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: controller.genderList.map((
                                  String items,
                                ) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  controller.selectedGender.value = newValue!;
                                  if (controller.selectedGender.value ==
                                      "Male") {
                                    controller.user.value.sex = "M";
                                  } else {
                                    controller.user.value.sex = "F";
                                  }  
                                },
                              )
                              .marginOnly(
                                left: 20,
                                right: 20,
                                top: 10,
                                bottom: 10,
                              )
                              .paddingOnly(top: 20, bottom: 14),
                    ),
                  ).paddingOnly(left: 20, right: 20, top: 20, bottom: 14),
                ],
              );
            }),

            //
            // Text("Change password".tr, style: Get.textTheme.headlineSmall).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
            // Text("Fill your old password and type new password and confirm it".tr, style: Get.textTheme.labelSmall).paddingSymmetric(horizontal: 22, vertical: 5),
            // Obx(() {
            //   return WOHTextFieldWidget(
            //     labelText: "Old Password".tr,
            //     hintText: "••••••••••••".tr,
            //     onSaved: (input) => controller.oldPassword.value = input,
            //     onChanged: (input) => controller.oldPassword.value = input,
            //     validator: (input) => input.length > 0 && input.length < 3 ? "Should be more than 3 letters".tr : null,
            //     //initialValue: controller.oldPassword.value,
            //     obscureText: controller.hidePassword.value,
            //     iconData: Icons.lock_outline,
            //     keyboardType: TextInputType.visiblePassword,
            //     suffixIcon: IconButton(
            //       onPressed: () {
            //         controller.hidePassword.value = !controller.hidePassword.value;
            //       },
            //       color: Theme.of(context).focusColor,
            //       icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
            //     ),
            //     isFirst: true,
            //     isLast: false,
            //   );
            // }),
            // Obx(() {
            //   return WOHTextFieldWidget(
            //     labelText: "New Password".tr,
            //     hintText: "••••••••••••".tr,
            //     onSaved: (input) => controller.user.value.password = input,
            //     onChanged: (input) => controller.newPassword.value = input,
            //     // validator: (input) {
            //     //   if (input.length > 0 && input.length < 3) {
            //     //     return "Should be more than 3 letters".tr;
            //     //   } else if (input != controller.confirmPassword.value) {
            //     //     return "Passwords do not match".tr;
            //     //   } else {
            //     //     return null;
            //     //   }
            //     // },
            //     //initialValue: controller.newPassword.value,
            //     obscureText: controller.hidePassword.value,
            //     iconData: Icons.lock_outline,
            //     keyboardType: TextInputType.visiblePassword,
            //     isFirst: false,
            //     isLast: false,
            //   );
            // }),
            // Obx(() {
            //   return WOHTextFieldWidget(
            //     labelText: "Confirm New Password".tr,
            //     hintText: "••••••••••••".tr,
            //     //editable: controller.editPassword.value,
            //     onSaved: (input) => controller.confirmPassword.value = input,
            //     onChanged: (input) => controller.confirmPassword.value = input,
            //     validator: (input) {
            //       if (input.length > 0 && input.length < 3) {
            //         return "Should be more than 3 letters".tr;
            //       } else if (input != controller.newPassword.value) {
            //         return "Passwords do not match".tr;
            //       } else {
            //         return null;
            //       }
            //     },
            //     //initialValue: controller.confirmPassword.value,
            //     obscureText: controller.hidePassword.value,
            //     iconData: Icons.lock_outline,
            //     keyboardType: TextInputType.visiblePassword,
            //     isFirst: false,
            //     isLast: true,
            //   );
            // }),
            WOHUpdatePasswordWidget(),
            WOHDeleteAccountWidget(),
          ],
        ),
      ),
    );
  }
}