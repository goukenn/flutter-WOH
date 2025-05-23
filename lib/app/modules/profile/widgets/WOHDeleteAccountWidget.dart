// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart'; 
import '../../root/controllers/WOHRootController.dart';
import '../controllers/WOHProfileController.dart';

class WOHDeleteAccountWidget extends GetView<WOHProfileController> {
  WOHDeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text("Delete your account!", style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Colors.redAccent))),
                Text("Once you delete this account, there is no going back. Please be certain.", style: Get.textTheme.labelSmall!.merge(TextStyle(color: Colors.redAccent))),
              ],
            ),
          ),
          SizedBox(width: 10),
          Obx(() {
            if (Get.find<WOHLaravelApiClientProvider>().isLoading(task: 'deleteUser', tasks:[])) {
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
                _showDeleteDialog(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.redAccent,
              child: Text("Delete".tr, style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor))),
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

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete your account!".tr,
            style: TextStyle(color: Colors.redAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Once you delete this account, there is no going back. Please be certain.".tr, style: Get.textTheme.bodyLarge),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel".tr, style: Get.textTheme.bodyLarge),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                "Confirm".tr,
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () async {
                Get.back();
                await controller.deleteUser();
                await Get.find<WOHRootController>().changePage(0);
              },
            ),
          ],
        );
      },
    );
  }
}