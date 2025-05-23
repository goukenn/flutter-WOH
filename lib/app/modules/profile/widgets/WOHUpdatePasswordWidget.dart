// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../controllers/WOHProfileController.dart';

class WOHUpdatePasswordWidget extends GetView<WOHProfileController> {
  WOHUpdatePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>WOHProfileController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: WOHUi.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Change password!", style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.redAccent))),
                Text("Fill your old password and type new password and confirm it", style: Get.textTheme.labelSmall!.merge(TextStyle(color: Colors.redAccent))),
              ],
            ),
          ),
          SizedBox(width: 10),
          Obx(() {
            if (Get.find<WOHLaravelApiClientProvider>().isLoading(task: 'deleteUser')) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                  ),
                ),
              );
            }
            return MaterialButton(
              onPressed: () {
                return Get.bottomSheet(
                  buildEditingSheet(context),
                  isScrollControlled: true,)!;
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Get.theme.colorScheme.secondary,
              child: Text("Change".tr, style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor))),
              elevation: 0,
              highlightElevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
            );
          }),
        ],
      ),
    );
  }


  Widget buildEditingSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: Get.height/1.8,
      decoration: BoxDecoration(
        color: background,
        //Get.theme.primaryColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.4).toInt()), blurRadius: 30, offset: Offset(0, -30)),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                return Get.bottomSheet(
                  buildEditingSheet(context),
                  isScrollControlled: true,);
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Get.theme.colorScheme.secondary,
              child: Text("Confirm".tr, style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor))),
              elevation: 0,
              highlightElevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
            ),
          ),

          Obx(() {
            return WOHTextFieldWidget(
              labelText: "Old Password".tr,
              hintText: "••••••••••••".tr,
              onSaved: (input) => controller.oldPassword.value = input,
              onChanged: (input) => controller.oldPassword.value = input,
              validator: (input) => input.length > 0 && input.length < 3 ? "Should be more than 3 letters".tr : null,
              //initialValue: controller.oldPassword.value,
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
              isFirst: true,
              isLast: false,
            );
          }).marginOnly(bottom: 10),
          Obx(() {
            return WOHTextFieldWidget(
              labelText: "New Password".tr,
              hintText: "••••••••••••".tr,
              onSaved: (input) => controller.user.value.password = input,
              onChanged: (input) => controller.newPassword.value = input,
              // validator: (input) {
              //   if (input.length > 0 && input.length < 3) {
              //     return "Should be more than 3 letters".tr;
              //   } else if (input != controller.confirmPassword.value) {
              //     return "Passwords do not match".tr;
              //   } else {
              //     return null;
              //   }
              // },
              //initialValue: controller.newPassword.value,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              isFirst: false,
              isLast: false,
            );
          }).marginOnly(bottom: 10),
          Obx(() {
            return WOHTextFieldWidget(
              labelText: "Confirm New Password".tr,
              hintText: "••••••••••••".tr,
              //editable: controller.editPassword.value,
              onSaved: (input) => controller.confirmPassword.value = input,
              onChanged: (input) => controller.confirmPassword.value = input,
              validator: (input) {
                if (input!.isNotEmpty && input.length < 3) {
                  return "Should be more than 3 letters".tr;
                } else if (input != controller.newPassword.value) {
                  return "Passwords do not match".tr;
                } else {
                  return null;
                }
              },
              //initialValue: controller.confirmPassword.value,
              obscureText: controller.hidePassword.value,
              iconData: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              isFirst: false,
              isLast: true,
            );
          }).marginOnly(bottom: 10),
        ],),
      ),
    );
  }

  // void _showDeleteDialog(BuildContext context) {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           "Delete your account!".tr,
  //           style: TextStyle(color: Colors.redAccent),
  //         ),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: <Widget>[
  //               Text("Once you delete this account, there is no going back. Please be certain.".tr, style: Get.textTheme.bodyLarge),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text("Cancel".tr, style: Get.textTheme.bodyLarge),
  //             onPressed: () {
  //               Get.back();
  //             },
  //           ),
  //           TextButton(
  //             child: Text(
  //               "Confirm".tr,
  //               style: TextStyle(color: Colors.redAccent),
  //             ),
  //             onPressed: () async {
  //               Get.back();
  //               await controller.deleteUser();
  //               await Get.find<WOHRootController>().changePage(0);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}