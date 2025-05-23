// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHCustomPageModel.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHDrawerLinkWidget.dart';
import '../../root/controllers/WOHRootController.dart';

class WOHCustomPageDrawerLinkWidget extends GetView<WOHRootController> {
  const WOHCustomPageDrawerLinkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.customPages.isEmpty) {
        return SizedBox();
      }
      return Column(
        children: List.generate(controller.customPages.length, (index) {
          var _page = controller.customPages.elementAt(index);
          return WOHDrawerLinkWidget(
            icon: getDrawerLinkIcon(_page),
            text: _page.title!,
            onTap: (e) async {
              //print(_page.id);
              await Get.offAndToNamed(WOHRoutes.CUSTOM_PAGES, arguments: _page);
            },
          );
        }),
      );
    });
  }

  IconData getDrawerLinkIcon(WOHCustomPageModel _page) {
    switch (_page.id) {
      case '1':
        return Icons.privacy_tip_outlined;
      default:
        return Icons.article_outlined;
    }
  }
}